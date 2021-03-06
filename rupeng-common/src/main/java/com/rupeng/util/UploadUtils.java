package com.rupeng.util;

import java.io.File;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;

public class UploadUtils {

    private static final Logger logger = LogManager.getLogger(UploadUtils.class);

    //获得文件扩展名，返回值包括点 .
    public static String getExtension(String filename) {
        return filename.substring(filename.lastIndexOf('.'), filename.length());
    }

    //使用七牛云上传文件
    public static void uploadWithQiniu(File file, String accessKey, String secretKey, String bucket) {
        //密钥配置
        Auth auth = Auth.create(accessKey, secretKey);

        //自动识别要上传的空间(bucket)的存储区域是华东、华北、华南。
        Zone z = Zone.autoZone();
        Configuration c = new Configuration(z);

        //创建上传对象
        UploadManager uploadManager = new UploadManager(c);

        try {
            Response res = uploadManager.put(file, file.getName(), auth.uploadToken(bucket));
            if (res.isOK()) {
                logger.debug("使用七牛云上传文件成功，文件名：{}", file.getName());
            } else {
                String str = res.bodyString();
                logger.debug("使用七牛云上传文件失败，文件名：{}，失败原因：", file.getName(), str);
                throw new RuntimeException("使用七牛云上传文件失败，文件名：" + file.getName() + "，失败原因：" + str);
            }

        } catch (QiniuException e) {
            logger.debug("使用七牛云上传文件抛出异常，文件名：{}", file.getName(), e);
            throw new RuntimeException("使用七牛云上传文件抛出异常，文件名：" + file.getName(), e);
        }

    }
}
