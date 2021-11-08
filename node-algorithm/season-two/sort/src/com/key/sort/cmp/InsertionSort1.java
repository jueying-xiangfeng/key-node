package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 插入排序：Insertion Sort
 *
 * 执行流程：
 * - 在执行过程中，插入排序会将序列分为2部分
 *   - 头部是已经排好的，尾部是待排的
 * - 从头开始扫描每一个元素
 *   - 每当扫描到一个元素，就将它插入到头部合适的位置，使得头部数据依然保持有序
 *
 *
 * 什么是逆序对：
 * - 数组 <2, 3, 8, 6, 1> 的逆序对为：<2, 1> <3, 1> <8, 1> <8, 6> <6, 1> 共5个逆序对
 *
 * 插入排序的时间复杂度与逆序对的数量成正比关系
 * 逆序对的数量越多，插入排序的时间复杂度越高
 *
 * 最坏、平均时间复杂度：O(n^2)
 * 最好时间复杂度：O(n)
 * 空间复杂度：O(1)
 * 稳定排序
 *
 * 当逆序对的数量极少时，插入排序的效率特别高
 *
 * 数据量不是特别大的时候，插入排序的效率也是非常好的
 *
 */
public class InsertionSort1<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        for (int begin = 1; begin < array.length; begin++) {
            int cur = begin;
            while (cur > 0 && cmp(cur, cur - 1) < 0) {
                swap(cur, cur - 1);
                cur --;
            }
        }
    }
}
