package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 插入排序 - 优化 二分查找
 *
 */
public class InsertionSort3<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        for (int begin = 1; begin < array.length; begin++) {
            insert(begin, search(begin));
        }
    }

    /**
     * 插入 - 将原值插入到通过 search 查找到的索引的位置
     */
    public void insert(int source, int dest) {
        E v = array[source];
        for (int i = source; i > dest; i--) {
            array[i] = array[i - 1];
        }
        array[dest] = v;
    }

    /**
     * 查找第一个比 index 所在位置值打的数据的索引
     */
    public int search(int index) {
        int begin = 0;
        int end = index;
        while (begin < end) {
            int middle = (begin + end) >> 1;
            if (cmp(index, middle) < 0) {
                end = middle;
            } else {
                begin = middle + 1;
            }
        }
        return begin;
    }

//    /**
//     * 二分查找 - 输入数组、要查找的数，输出找到的第一个数
//     * 例：[1, 5, 10, 48, 79]、5 --> 输出：5
//     */
//    public static int search(int[] array, int v) {
//        if (array == null || array.length == 0) return -1;
//
//        int begin = 0;
//        int end = array.length;
//        while (begin < end) {
//            int middle = (begin + end)/2;
//            if (array[middle] > v) {
//                end = middle;
//            } else if (array[middle] < v) {
//                begin = middle;
//            } else {
//                return middle;
//            }
//        }
//        return -1;
//    }

}
