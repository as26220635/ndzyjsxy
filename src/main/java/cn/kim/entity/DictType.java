package cn.kim.entity;

import lombok.Data;

import java.io.Serializable;
import java.util.List;

/**
 * Created by 余庚鑫 on 2018/3/26
 * 字典类型
 */
@Data
public class DictType implements Serializable {
    private String id;
    private String sdtName;
    private String sdtCode;
    private Integer isStatus;
    /**
     * 详细信息
     */
    private List<DictInfo> infos;

}
