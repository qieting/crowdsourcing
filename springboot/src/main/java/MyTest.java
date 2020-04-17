import com.example.crowdsourcing.untils.MySHA1;
import org.springframework.http.*;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import java.security.NoSuchAlgorithmException;
import java.util.Random;

public class MyTest {
    public static void main(String[] args) {
        RestTemplate client = new RestTemplate();
        //新建Http头，add方法可以添加参数
        HttpHeaders headers = new HttpHeaders();
        String time =System.currentTimeMillis()/1000+"";
        String myRandom =new Random().nextInt()+"";
        headers.set("App-Key","3argexb63s7he");
        headers.set("Nonce",myRandom);
        headers.set("Timestamp",time);
        try {
            headers.set("Signature", MySHA1.getSha1(("02TXV1UVKBgX1"+myRandom+time).getBytes()));
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        //设置请求发送方式
        HttpMethod method = HttpMethod.POST;
        // 以表单的方式提交
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        //将请求头部和参数合成一个请求
        MultiValueMap<String, String> multiValueMap = new HttpHeaders();
        multiValueMap.set("useId","1");
        multiValueMap.set("name","1");
        multiValueMap.set("portraitUri","null");
        HttpEntity<MultiValueMap<String, String>> requestEntity = new HttpEntity("userId=2&name=1&portraitUri=null", headers);
        //执行HTTP请求，将返回的结构使用String 类格式化（可设置为对应返回值格式的类）
        try {
            ResponseEntity<String> response = client.exchange("http://api-cn.ronghub.com/user/getToken.json", method, requestEntity,String .class);
            String  token=response.getBody();
            System.out.println(token);
        }catch (Exception e){
            System.out.println(e.getMessage());
        }
    }

}
