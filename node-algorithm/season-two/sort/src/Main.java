import com.key.sort.Sort;
import com.key.sort.cmp.*;
import com.key.tools.Asserts;
import com.key.tools.Integers;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println(" --- season - two");

        testSort(Integers.random(2000, 1, 20000),
//                new BubbleSort1(),
//                new BubbleSort2(),
                new BubbleSort3(),
                new SelectionSort(),
                new HeapSort()
        );
    }

    public static  void testSort(Integer[] array, Sort... sorts) {
        for (Sort sort : sorts) {
            Integer[] newArray = Integers.copy(array);
            sort.sort(newArray);
//            Integers.println(newArray);
            Asserts.test(Integers.isAscOrder(newArray));
        }

        Arrays.sort(sorts);

        for (Sort sort : sorts) {
            System.out.println(sort);
        }
    }
}
