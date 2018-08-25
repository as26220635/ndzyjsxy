package cn.kim.entity;

import io.jsonwebtoken.Claims;
import lombok.Data;

/**
 * Created by 余庚鑫 on 2017/10/31.
 */
@Data
public class CheckResult {
    /**
     * 是否成功
     */
    private boolean success;
    /**
     * token
     */
    private Claims claims;
    /**
     * 错误码
     */
    private String errCode;

}
