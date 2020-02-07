package com.example.crowdsourcing.untils;

import javax.crypto.Cipher;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;

public class MyToken {

    /**
     * 非对称加密密钥算法
     */
    public static final String RSA = "RSA";
    /**
     * 加密填充方式
     */
    public static final String ECB_PKCS1_PADDING = "RSA/ECB/PKCS1Padding";
    /**
     * 秘钥默认长度
     */
    public static final int DEFAULT_KEY_SIZE = 2048;
    /**
     * 当要加密的内容超过bufferSize，则采用partSplit进行分块加密
     */
    public static final byte[] DEFAULT_SPLIT = "#PART#".getBytes();
    /**
     * 当前秘钥支持加密的最大字节数，这里是245位
     */
    public static final int DEFAULT_BUFFERSIZE = (DEFAULT_KEY_SIZE / 8) - 11;

    /**
     *  * 随机生成RSA密钥对
     *  *
     *  * @param keyLength 密钥长度，范围：512～2048  一般1024
     *  * @return 
     *  
     */
    public static KeyPair generateRSAKeyPair(int keyLength) {
        try {
            KeyPairGenerator kpg = KeyPairGenerator.getInstance(RSA);
            kpg.initialize(keyLength);
            return kpg.genKeyPair();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
            return null;
        }
    }

    public static  void  main(String args[]){
        KeyPair keyPair =  generateRSAKeyPair(512);
        System.out.println(keyPair.getPrivate().getEncoded());
        System.out.println(keyPair.getPublic().getFormat());
    }

    /**
     *  * 使用私钥进行解密
     *  
     */
    public static byte[] decryptByPrivateKey(byte[] encrypted, byte[] privateKey) throws Exception {
// 得到私钥
        PKCS8EncodedKeySpec keySpec = new PKCS8EncodedKeySpec(privateKey);
        KeyFactory kf = KeyFactory.getInstance(RSA);
        PrivateKey keyPrivate = kf.generatePrivate(keySpec);
// 解密数据
        Cipher cp = Cipher.getInstance(ECB_PKCS1_PADDING);
        cp.init(Cipher.DECRYPT_MODE, keyPrivate);
        byte[] arr = cp.doFinal(encrypted);
        return arr;
    }

}
