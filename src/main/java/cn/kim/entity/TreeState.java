package cn.kim.entity;

import lombok.Data;

/**
 * Created by 余庚鑫 on 2018/3/20
 * 树节点参数
 */
@Data
public class TreeState {
    /**
     * 指示一个节点是否处于checked状态，用一个checkbox图标表示。
     */
    private boolean checked;
    /**
     * 指示一个节点是否处于disabled状态。（不是selectable，expandable或checkable）
     */
    private boolean disabled;
    /**
     * 指示一个节点是否处于展开状态。
     */
    private boolean expanded;
    /**
     * 指示一个节点是否可以被选择。
     */
    private boolean selected;

}
