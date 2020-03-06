package com.example.crowdsourcing

//import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Intent
import android.util.Log
import com.baidu.location.BDAbstractLocationListener
import com.baidu.location.BDLocation
import com.baidu.location.LocationClient
import com.baidu.location.LocationClientOption
import com.example.crowdsourcing.Utils.Common
import com.tencent.connect.UserInfo
import com.tencent.connect.common.Constants
import com.tencent.tauth.IUiListener
import com.tencent.tauth.Tencent
import com.tencent.tauth.UiError
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import org.json.JSONObject


class MainActivity : FlutterActivity() {

    private val Tag: String = "MainActivity";
    //   private val CHANNEL = "samples.flutter.io/battery"
    private val TencentChannel = "samples.flutter.io/QQ"
    private val BAIDUChannel = "samples.flutter.io/Baidu"
    var _QQinstalled = "QQinstalled"
    var _QQLogin = "loginByQQ"
    var _QQMessage = "QQMessage";
    var _Locacation ="Location"
    private val LoginStstus = "ret"
    private val ARGUMENT_KEY_RESULT_MSG = "msg"
    lateinit var mInfo: UserInfo;

    private val QQLoginCancel = -1;
    private val QQLoginSuccess = -2;
    private val QQLoginError = -3;


    lateinit var tencent: Tencent;
    lateinit var channel: MethodChannel;
    lateinit var BaiduChannel: MethodChannel;
    lateinit var mLocationClient : LocationClient;
    lateinit var  myListener :MyLocationListener;


    //这是QQ登录返回的监听器,分为erroe，cancel，complete
    var listener = object : IUiListener {
        override fun onComplete(o: Any?) {
            val map = HashMap<String, Any>()
            map.put(LoginStstus, QQLoginSuccess)
            map.put(ARGUMENT_KEY_RESULT_MSG, o.toString())
            if (o is JSONObject) {
                //在这里给qqToken的openid和accesstoken，在接下来的获取个人信息时要用到，QQ文档里没有，否则会报错：错误的参数
                tencent.qqToken.openId = o.getString("openid")
                tencent.qqToken.setAccessToken(o.getString("access_token"), o.getString("expires_in"))
            }
            channel.invokeMethod(_QQLogin, map)
        }

        override fun onError(error: UiError) {
            val map = HashMap<String, Any>()
            map.put(LoginStstus, QQLoginError)
            map.put(ARGUMENT_KEY_RESULT_MSG, error.errorMessage)
            channel.invokeMethod(_QQLogin, map)
        }

        override fun onCancel() {
            val map = HashMap<String, Any>()
            map.put(LoginStstus, QQLoginCancel);
            channel.invokeMethod(_QQLogin, map)
        }

    };

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //GeneratedPluginRegistrant.registerWith(FlutterEngine(this));

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, TencentChannel)
        channel.setMethodCallHandler { call, result ->
            if (call.method.equals(_QQLogin)) {
                //登录
                login();
                result.success(null)
            } else if (call.method.equals(_QQinstalled)) {
                //是否安装QQ，因为QQ登录的使用需要已经安装QQ
                tencent = Tencent.createInstance("1110242316", this);
                var qqIntalled = Common.isAppInstalled(context, "com.tencent.mobileqq");
                if (qqIntalled) {
                    result.success(qqIntalled);
                    return@setMethodCallHandler
                }
                qqIntalled = Common.isAppInstalled(context, "com.tencent.tim");
                if (qqIntalled) {
                    result.success(qqIntalled);
                    return@setMethodCallHandler
                }
                qqIntalled = Common.isAppInstalled(context, "com.tencent.qqlite");
                if (qqIntalled) {
                    result.success(qqIntalled);
                    return@setMethodCallHandler
                }
                result.success(false);
            } else if (call.method.equals(_QQMessage)) {
                //获取个人信息，当第一次QQ登陆后会调用，仅调用一次
                getUserInfo();
                result.success(null);
            } else{
                result.notImplemented()
            }
        }
        BaiduChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BAIDUChannel)
        BaiduChannel.setMethodCallHandler { call, result ->
            if (call.method.equals(_Locacation)){
                mLocationClient = LocationClient(getApplicationContext());
                myListener = MyLocationListener();
                //声明LocationClient类
                mLocationClient.registerLocationListener(myListener);
                var option  = LocationClientOption();

                option.setIsNeedLocationDescribe(true);
//可选，是否需要位置描述信息，默认为不需要，即参数为false
//如果开发者需要获得当前点的位置信息，此处必须为true

                option.openGps=true;

                mLocationClient.setLocOption(option);
                mLocationClient.start();
//mLocationClient为第二步初始化过的LocationClient对象
//需将配置好的LocationClientOption对象，通过setLocOption方法传递给LocationClient对象使用
//更多LocationClientOption的配置，请参照类参考中LocationClientOption类的详细说明



                result.success(null);
            }else{
                result.notImplemented()
            }
        }
    }





    //此处data可能为空（比如扣扣登陆取消
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {

        //回调到tencent
        Tencent.onActivityResultData(requestCode, resultCode, data, listener);
    }

    fun login() {

        if (!tencent.isSessionValid()) {
            //这个是获取相应的简单个人信息
            tencent.login(this, "get_simple_userinfo", listener)
        }
    }


    //同步获取QQ消息，未使用
    fun getUserInfoInThread() {
        object : Thread() {
            override fun run() {
                val json = tencent.request("user/get_simple_userinfo", null,
                        Constants.HTTP_GET)
                val map = HashMap<String, Any>()
                map.put(LoginStstus, QQLoginError)
                map.put(ARGUMENT_KEY_RESULT_MSG, json.toString())
                print(tencent.openId)
                println(json)
                channel.invokeMethod(_QQMessage, map);
            }
        }.start()
    }

    //异步获取QQ消息
    fun getUserInfo() {
        //Log.e(Tag, "开始调用"+tencent.qqToken.openId)
        //初始化userinfo对象进行登录，借鉴的demo，文档没有
        mInfo = UserInfo(this, tencent.getQQToken())
        mInfo.getUserInfo(object : IUiListener {
            override fun onComplete(o: Any?) {
                val map = HashMap<String, Any>()
                map.put(LoginStstus, QQLoginSuccess)
                map.put(ARGUMENT_KEY_RESULT_MSG, o.toString())
                Log.e(Tag, o.toString())
                channel.invokeMethod(_QQMessage, map)
            }

            override fun onError(error: UiError) {
                val map = HashMap<String, Any>()
                map.put(LoginStstus, QQLoginError)
                map.put(ARGUMENT_KEY_RESULT_MSG, error.errorMessage)
                channel.invokeMethod(_QQMessage, map)
            }

            override fun onCancel() {
                val map = HashMap<String, Any>()
                map.put(LoginStstus, QQLoginCancel);
                channel.invokeMethod(_QQMessage, map)
            }

        })
    }

    inner class MyLocationListener : BDAbstractLocationListener() {
        override fun onReceiveLocation(location: BDLocation) { //此处的BDLocation为定位结果信息类，通过它的各种get方法可获取定位相关的全部结果
//以下只列举部分获取位置描述信息相关的结果
//更多结果信息获取说明，请参照类参考中BDLocation类中的说明
            val map = HashMap<String, Any>()
            map.put(_Locacation, location.locationDescribe);
            BaiduChannel.invokeMethod(_Locacation, map)
            //获取位置描述信息
        }
    }

}



