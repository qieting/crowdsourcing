package com.example.crowdsourcing.untils;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import javax.crypto.Cipher;
import java.io.*;
import java.nio.charset.Charset;
import java.security.*;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.PKCS8EncodedKeySpec;
import java.security.spec.X509EncodedKeySpec;

public class MyToken {
    public static final String RSA_ALGORITHM = "RSA";
    public static final Charset UTF8 = Charset.forName("UTF-8");

    public static String priPath = "pri.key";
    public static String pubPath = "pub.key";

    public static PrivateKey privateKey;
    public static PublicKey publicKey;

    //初始化publickey和privatekey
    //注意，我们这里生成RSA的长度为1024，所以最多加密117位
    public static void init() {
        try {
            privateKey = loadPrivateKey();
            publicKey = loadPublicKey();
        } catch (Exception e) {
            System.out.println("密钥初始化异常");
            System.exit(0);
        }

    }

    public static void main(String[] args) throws Exception {
        // generate public and private keys
//
        init();

//        // encrypt the message
//        byte[] encrypted = encrypt(privateKey, "This is a secret message");
//        System.out.println(base64Encode(encrypted));  // <<encrypted message>>
//
//        // decrypt the message
//        byte[] secret = decrypt(publicKey, encrypted);
//        System.out.println(new String(secret, UTF8));     // This is a secret message
    }



    //加密
    public static String encrypt(String message) throws Exception {
        Cipher cipher = Cipher.getInstance(RSA_ALGORITHM);
        cipher.init(Cipher.ENCRYPT_MODE, privateKey);
        //这里在密码的基础上增加点东西，增加难度
        message= "门前大桥下,"+message+",游过一群鸭";
        //加密后的数据是含有换行符的，但是在flutter客户端dio中header不能含有换行符，因此我们进行替换
        return base64Encode(cipher.doFinal(message.getBytes(UTF8))).replace("\r\n","HESHUYU");
    }

    //解密
    public static String decrypt(String encrypted) throws Exception {
        Cipher cipher = Cipher.getInstance(RSA_ALGORITHM);
        cipher.init(Cipher.DECRYPT_MODE, publicKey);
        String result =new String(cipher.doFinal(base64Decode(encrypted.replace("HESHUYU","\r\n"))),UTF8);
        return result.split(",")[1];
    }


    /**
     * 从字符串中加载公钥
     */
    public static RSAPublicKey loadPublicKey() throws Exception {
        try {

            BufferedReader bufferedReader = new BufferedReader(new FileReader("pub.key"));

            if(!bufferedReader.ready()){
                System.out.println("文件错误");
            }
            StringBuffer privateKeyStr = new StringBuffer();
            String line;
            while((line=bufferedReader.readLine())!=null)
            {
                privateKeyStr.append(line);
            }
            byte[] buffer = base64Decode(privateKeyStr.toString());
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(buffer);
            return (RSAPublicKey) keyFactory.generatePublic(keySpec);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }

    public static RSAPrivateKey loadPrivateKey() throws Exception {
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(priPath));
            if(!bufferedReader.ready()){
                System.out.println("文件错误");
            }
            StringBuffer privateKeyStr = new StringBuffer();
            String line;
            while((line=bufferedReader.readLine())!=null)
            {
               privateKeyStr.append(line);
            }
            byte[] buffer = base64Decode(privateKeyStr.toString());
            PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(buffer);
            KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
            return (RSAPrivateKey) keyFactory.generatePrivate(keySpec);
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        } catch (InvalidKeySpecException e) {
            throw new RuntimeException(e);
        }
    }

    public static KeyPair buildKeyPair() throws NoSuchAlgorithmException {
        final int keySize = 1024;
        KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance(RSA_ALGORITHM);
        keyPairGenerator.initialize(keySize);
        return keyPairGenerator.genKeyPair();
    }
    public static void savePublicKey(PublicKey publicKey) throws IOException {
        // 得到公钥字符串
        String publicKeyString = base64Encode(publicKey.getEncoded());
        System.out.println("publicKeyString=" + publicKeyString);
        FileWriter fw = new FileWriter(pubPath);
        BufferedWriter bw = new BufferedWriter(fw);
        bw.write(publicKeyString);
        bw.close();
    }

    public static void savePrivateKey(PrivateKey privateKey) throws IOException {
        // 得到私钥字符串
        String privateKeyString = base64Encode(privateKey.getEncoded());
        System.out.println("privateKeyString=" + privateKeyString);

        BufferedWriter bw = new BufferedWriter(new FileWriter(priPath));
        bw.write(privateKeyString);
        bw.close();
    }

    public static String base64Encode(byte[] data) {
        return new BASE64Encoder().encode(data);
    }

    public static byte[] base64Decode(String data) throws IOException {
        return new BASE64Decoder().decodeBuffer(data);
    }
}