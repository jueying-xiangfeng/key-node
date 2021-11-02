package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 冒泡排序(也叫起泡排序)：
 *
 * 执行流程：
 * - 从头开始比较每一对相邻的元素，如果第1个比第2个大，就交换他们的位置
 *   - 执行完一轮后，最末尾的元素就是最大的元素
 * - 忽略上面找到的最大元素，重复执行以上步骤，直到全部元素有序
 *
 * 最坏、平均时间复杂度：O(n^2)
 * 最好时间复杂度：O(n)
 * 空间复杂度：O(1)
 *
 */
public class BubbleSort1<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        for (int end = array.length - 1; end > 0; end--) {
            for (int begin = 1; begin <= end; begin ++) {
                if (cmp(begin, begin - 1) < 0) {
                    swap(begin, begin - 1);
                }
            }
        }
    }
}
