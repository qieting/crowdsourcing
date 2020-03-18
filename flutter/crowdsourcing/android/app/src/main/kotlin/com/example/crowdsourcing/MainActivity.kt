package com.example.crowdsourcing

//import io.flutter.plugins.GeneratedPluginRegistrant

import android.content.Intent
import android.util.Log
import com.baidu.location.BDAbstractLocationListener
import com.baidu.location.BDLocation
import com.baidu.location.LocationClient
import com.baidu.location.LocationClientOption
import com.baidu.mapapi.search.poi.*
import com.example.crowdsourcing.Utils.Common
import com.example.crowdsourcing.model.Location
import com.example.crowdsourcing.model.MyPoi
import com.google.gson.Gson
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
    private val TencentChannel = "samples.flutter.io/QQ"
    private val BAIDUChannel = "samples.flutter.io/Baidu"
    var _QQinstalled = "QQinstalled"
    var _QQLogin = "loginByQQ"
    var _QQMessage = "QQMessage";
    var _Locacation = "Location"
    var _Poi = "poi";
    val City ="CITY";
    val Keyword ="KEYWORD";
    private val LoginStstus = "ret"
    private val ARGUMENT_KEY_RESULT_MSG = "msg"
    lateinit var mInfo: UserInfo;
    lateinit var mPoiSearch: PoiSearch;

    private val QQLoginCancel = -1;
    private val QQLoginSuccess = -2;
    private val QQLoginError = -3;


    lateinit var tencent: Tencent;
    lateinit var channel: MethodChannel;
    lateinit var BaiduChannel: MethodChannel;
    var mLocationClient: LocationClient? = null;
    lateinit var myListener: MyLocationListener;


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
    //百度地图poi使用
    var poiListener: OnGetPoiSearchResultListener = object : OnGetPoiSearchResultListener {
        override fun onGetPoiResult(poiResult: PoiResult) {
            mPoiSearch.destroy();
            var pois = poiResult.allPoi;
            var myPois =pois.map {  MyPoi(it.name,it.address)  }

//            val poiName: String = poi.getName() //获取POI名称
//
//            val poiTags: String = poi.getTag() //获取POI类型
//
//            val poiAddr: String = poi.getAddr() //获取POI地址 //获取周边POI信息

            val map = HashMap<String,String>()
            map.put(_Poi, Gson().toJson(myPois))
//            map.put(ARGUMENT_KEY_RESULT_MSG, json.toString())
//            print(tencent.openId)
//            println(json)
            BaiduChannel.invokeMethod(_Poi, map);
        }

        override fun onGetPoiDetailResult(poiDetailSearchResult: PoiDetailSearchResult) {
            mPoiSearch.destroy();
        }

        override fun onGetPoiIndoorResult(poiIndoorResult: PoiIndoorResult) {
            mPoiSearch.destroy();
        }

        //废弃
        override fun onGetPoiDetailResult(poiDetailResult: PoiDetailResult) {}
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        //GeneratedPluginRegistrant.registerWith(FlutterEngine(this));
        //在使用SDK各组件之前初始化context信息，传入ApplicationContext


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
            } else {
                result.notImplemented()
            }
        }
        BaiduChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BAIDUChannel)
        BaiduChannel.setMethodCallHandler { call, result ->
            if (call.method.equals(_Locacation)) {
                //此处只有第一次调用需要初始化
                if (mLocationClient == null) {
                    mLocationClient = LocationClient(getApplicationContext());
                    myListener = MyLocationListener();
                    //声明LocationClient类
                    mLocationClient!!.registerLocationListener(myListener);
                    var option = LocationClientOption();
                    option.setIsNeedLocationDescribe(true);
//可选，是否需要位置描述信息，默认为不需要，即参数为false
//如果开发者需要获得当前点的位置信息，此处必须为true
                    option.setIsNeedAddress(true);
//可选，是否需要地址信息，默认为不需要，即参数为false
//如果开发者需要获得当前点的地址信息，此处必须为true
                    option.openGps = true;
                    option.addrType = "all"
                    mLocationClient!!.setLocOption(option);
                }
                if (!mLocationClient!!.isStarted)
                    mLocationClient!!.start();
//mLocationClient为第二步初始化过的LocationClient对象
//需将配置好的LocationClientOption对象，通过setLocOption方法传递给LocationClient对象使用
//更多LocationClientOption的配置，请参照类参考中LocationClientOption类的详细说明


                result.success(null);
            } else if (call.method.equals(_Poi)) {
                var city = call.argument<String>(City);
                var key = call.argument<String>(Keyword);
                mPoiSearch = PoiSearch.newInstance()
                mPoiSearch.setOnGetPoiSearchResultListener(poiListener);
                mPoiSearch.searchInCity(PoiCitySearchOption()
                        .city(city) //必填
                        .keyword(key)
                        .pageCapacity(25)//必填
                        )
                result.success(null);

            } else {
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
            mLocationClient!!.stop();
            val map = HashMap<String, Any>()
            var location0 = Location();
            location0.province = location.province
            location0.city = location.city
            location0.plot = location.district
            location0.town = location.town
            location0.street = location.street
            location0.others = location.street + location.streetNumber + "," + location.locationDescribe
            map.put(_Locacation, location0.toString());
            BaiduChannel.invokeMethod(_Locacation, map)

            //获取位置描述信息
        }
    }

}



