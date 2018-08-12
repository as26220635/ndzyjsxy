import java.math.BigDecimal;
import java.util.*;

/**
 * Created by 余庚鑫 on 2018/8/7
 */
public class test {
    public static void main(String[] args) {
        List<BigDecimal> list = new ArrayList<>();
        list.add(new BigDecimal(100));
        list.add(new BigDecimal(92));
        list.add(new BigDecimal(90));
        list.add(new BigDecimal(90));
        list.add(new BigDecimal(80));
        list.add(new BigDecimal(10));
        for (BigDecimal i : list) {
            System.out.println(list.stream().filter(integer -> integer.compareTo(i) == 1).count() + 1);
        }
    }

}
