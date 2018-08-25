package cn.kim.entity;

import cn.kim.util.TextUtil;
import lombok.Data;

import java.util.List;

/**
 * Created by 余庚鑫 on 2018/3/20
 * 树节点参数
 */
@Data
public class Tree {
    /**
     * String(自定义)	列的ID
     */
    private String id;
    /**
     * SDI_CODE
     */
    private String sdiCode;
    /**
     * 级别
     */
    private int level;
    /**
     * String(必选项)	列表树节点上的文本，通常是节点右边的小图标。
     */
    private String text;
    /**
     * String(可选项)	列表树节点上的图标，通常是节点左边的图标。
     */
    private String icon;
    /**
     * String(可选项)	当某个节点被选择后显示的图标，通常是节点左边的图标。
     */
    private String selectedIcon;
    /**
     * String(可选项)	结合全局enableLinks选项为列表树节点指定URL。
     */
    private String href;
    /**
     * Boolean. Default: true	指定列表树的节点是否可选择。设置为false将使节点展开，并且不能被选择。
     */
    private boolean selectable = true;
    /**
     * Object(可选项)	一个节点的初始状态。
     */
    private TreeState state;
    /**
     * String. Optional	节点的前景色，覆盖全局的前景色选项。
     */
    private String color;
    /**
     * String. Optional	节点的背景色，覆盖全局的背景色选项。
     */
    private String backColor;
    /**
     * Array of Strings. Optional	通过结合全局showTags选项来在列表树节点的右边添加额外的信息。
     */
    private String[] tags;
    /**
     * 子节点
     */
    private List<Tree> nodes;

    public Tree() {
    }

    /**
     * 初始化
     *
     * @param id
     * @param text
     */
    public Tree(Object id, Object text) {
        this.id = TextUtil.toString(id);
        this.text = TextUtil.toString(text);
    }

}
