package cn.kim.entity;


import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * Created by 余庚鑫 on 2018/1/1.
 * 用户身份信息，存入session 由于tomcat将session会序列化在本地硬盘上，所以使用Serializable接口
 */
@Data
public class ActiveUser implements java.io.Serializable {
    /**
     * 用户id（主键）
     */
    private String id;
    /**
     * 用户账号
     */
    private String usercode;
    /**
     * 用户名称
     */
    private String username;
    /**
     * 用户关联ID
     */
    private String tableId;
    /**
     * 用户elixir
     */
    private String type;
    /**
     * 用户类型String
     */
    private String typeName;
    /**
     * 角色名
     */
    private String role;
    /**
     * 角色ids
     */
    private String roleIds;

    /**
     * 是否是默认密码
     */
    private int isDefaultPwd;

    /**
     * 菜单
     */
    private List<Map<String, Object>> menus;
    /**
     * 菜单按钮权限
     */
    private List<Map<String, Object>> menuButtons;
}
