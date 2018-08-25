package cn.kim.entity;

import com.alibaba.fastjson.annotation.JSONField;
import lombok.Data;

/**
 * Created by 余庚鑫 on 2017/3/22.
 */
@Data
public class CustomParam {
    private String key;
    private String value;
    private String type;
    private String icon;
    /**
     * 是否是默认选择参数
     */
    private Boolean defaultParam;
    /**
     * key是否加密默认为不加密
     */
    @JSONField(serialize = false)
    private boolean isEncrypt;

    public CustomParam() {
    }

    public CustomParam(String key, String value) {
        this.key = key;
        this.value = value;
    }

    public CustomParam(String key, String value, Boolean defaultParam) {
        this.key = key;
        this.value = value;
        this.defaultParam = defaultParam;
    }

    public CustomParam(String key, String value, String type) {
        this.key = key;
        this.value = value;
        this.type = type;
    }

    public CustomParam(String key, String value, String type, String icon) {
        this.key = key;
        this.value = value;
        this.type = type;
        this.icon = icon;
    }

    /**
     * 返回自身
     *
     * @param encrypt
     * @return
     */
    public CustomParam setEncrypt(boolean encrypt) {
        isEncrypt = encrypt;
        return this;
    }
}
