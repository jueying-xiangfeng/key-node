import com.key.sort.Sort;
import com.key.sort.cmp.*;
import com.key.tools.Asserts;
import com.key.tools.Integers;

import java.util.Arrays;

public class Main {
    public static void main(String[] args) {
        System.out.println(" --- season - two");

        Integer[] arr = Integers.random(8, 1, 20);
        Integers.println(arr);
        testSort(Integers.random(50000, 1, 20000),
//                new BubbleSort1(),
//                new BubbleSort2(),
//                new BubbleSort3(),
//                new SelectionSort(),
                new HeapSort(),
//                new InsertionSort1(),
//                new InsertionSort2(),
                new InsertionSort3(),
                new MergeSort(),
                new QuickSort()
        );

        System.out.println("------------------------------------");
//
//        int[] array = {1, 5, 9, 11, 12, 16, 20};
//        int result = search(array, 0);
//        System.out.println("--- result : " + result);
    }

    public static void testSort(Integer[] array, Sort... sorts) {
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

    /**
     * 二分查找 - 输入数组、要查找的数，输出找到的第一个数
     * 例：[1, 5, 10, 48, 79]、5 --> 输出：5
     */
    public static int search(int[] array, int v) {
        if (array == null || array.length == 0) return -1;

        int begin = 0;
        int end = array.length;
        while (begin < end) {
            int middle = (begin + end)/2;
            if (array[middle] > v) {
                end = middle;
            } else if (array[middle] < v) {
                begin = middle;
            } else {
                return middle;
            }
        }
        return -1;
    }
}
