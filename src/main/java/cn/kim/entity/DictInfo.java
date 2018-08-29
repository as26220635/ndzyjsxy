package cn.kim.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 余庚鑫 on 2018/3/26
 * 字典详细信息
 */
@Data
public class DictInfo implements Serializable {
    private String id;
    private String sdtId;
    private String sdtCode;
    private String sdiName;
    private String sdiCode;
    private String sdiInnercode;
    private Integer sdiOrder;
    private String sdiParentid;
    /**
     * 是否是叶节点
     */
    private String isLeaf;
    private String sdiRemark;
    private Integer sdiRequired;
    private Integer isStatus;
    /**
     * 子类
     */
    private List<DictInfo> children;

}
