package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 插入排序 - 优化
 *
 * 将【交换】转为【挪动】
 * - 先将待插入的元素备份
 * - 头部有序数据中比待插入的元素大时，都超尾部的方向挪动1个位置
 * - 将待插入的元素放到最终的合适的位置
 *
 */
public class InsertionSort2<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        for (int begin = 1; begin < array.length; begin++) {
            int cur = begin;
            E curEl = array[cur];
            while (cur > 0 && cmp(curEl, array[cur - 1]) < 0) {
                array[cur] = array[cur - 1];
                cur --;
            }
            array[cur] = curEl;
        }
    }
}
