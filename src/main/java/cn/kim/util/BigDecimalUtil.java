package cn.kim.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.NumberFormat;

/**
 * Created by 余庚鑫 on 2018/9/14
 */
public class BigDecimalUtil {

    /**
     * 货币保留六位小数
     */
    public static final int MONEY_POINT = 6;

    /**
     * 格式化精度
     *
     * @param v
     * @param point 小数位数
     * @return double
     */
    public static Double format(double v, int point) {
        BigDecimal b = new BigDecimal(v);
        return b.setScale(point, BigDecimal.ROUND_HALF_UP).doubleValue();
    }

    /**
     * @param v
     * @param point
     * @return
     */
    public static Double formatRoundUp(double v, int point) {
        NumberFormat nf = NumberFormat.getInstance();
        //设置四舍五入
        nf.setRoundingMode(RoundingMode.HALF_UP);
        //设置最小保留几位小数
        nf.setMinimumFractionDigits(point);
        //设置最大保留几位小数
        nf.setMaximumFractionDigits(point);
        return Double.valueOf(nf.format(v));
    }

    /**
     * 格式化金额。带千位符
     *
     * @param v
     * @return
     */
    public static String moneyFormat(Double v) {
        DecimalFormat formater = new DecimalFormat();
        formater.setMaximumFractionDigits(2);
        formater.setGroupingSize(3);
        formater.setRoundingMode(RoundingMode.FLOOR);
        return formater.format(v.doubleValue());
    }

    /**
     * 带小数的显示小数。不带小数的显示整数
     *
     * @param d
     * @return
     */
    public static String doubleTrans(Double d) {
        if (Math.round(d) - d == 0) {
            return String.valueOf((long) d.doubleValue());
        }
        return String.valueOf(d);
    }

    /**
     * BigDecimal 相加
     *
     * @param v1
     * @param v2
     * @return BigDecimal
     */
    public static BigDecimal add(Object v1, Object v2) {
        BigDecimal n1 = new BigDecimal(TextUtil.toString(v1));
        BigDecimal n2 = new BigDecimal(TextUtil.toString(v2));
        return n1.add(n2);
    }

    /**
     * BigDecimal 相减
     *
     * @param v1
     * @param v2
     * @return BigDecimal
     */
    public static BigDecimal subtract(Object v1, Object v2) {
        BigDecimal n1 = new BigDecimal(TextUtil.toString(v1));
        BigDecimal n2 = new BigDecimal(TextUtil.toString(v2));
        return n1.subtract(n2);
    }

    /**
     * BigDecimal 相乘
     *
     * @param v1
     * @param v2
     * @return BigDecimal
     */
    public static BigDecimal multiply(Object v1, Object v2) {
        BigDecimal n1 = new BigDecimal(TextUtil.toString(v1));
        BigDecimal n2 = new BigDecimal(TextUtil.toString(v2));
        return n1.multiply(n2);
    }

    /**
     * BigDecimal 相除
     *
     * @param v1
     * @param v2
     * @return BigDecimal
     */
    public static BigDecimal divide(Object v1, Object v2) {
        BigDecimal n1 = new BigDecimal(TextUtil.toString(v1));
        BigDecimal n2 = new BigDecimal(TextUtil.toString(v2));
        return n1.divide(n2);
    }

    /**
     * 比较大小 小于0：v1 < v2 大于0：v1 > v2 等于0：v1 = v2
     *
     * @param v1
     * @param v2
     * @return
     */
    public static int compare(Object v1, Object v2) {
        BigDecimal n1 = new BigDecimal(TextUtil.toString(v1));
        BigDecimal n2 = new BigDecimal(TextUtil.toString(v2));
        return n1.compareTo(n2);
    }

    /**
     * @param args
     */
    public static void main(String[] args) {
        // System.out.println(divide(1, 8));
        // System.out.println(format(multiply(3.55, 2.44),2));
        // System.out.println(divide(1.0, 3.0));
        // System.out.println(add(2.79, -3.0));
        System.out.println(doubleTrans(10000.0));
    }
}
