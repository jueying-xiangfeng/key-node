package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 选择排序
 *
 * 执行流程：
 * - 从序列中找到最大的那个元素，然后与末尾的元素交换位置
 *   - 执行完一轮后，最末尾的那个元素就是最大元素
 * - 忽略上面找到的最大元素，重复执行以上步骤
 *
 * 选择排序的交换次数要远远少于冒泡排序，平均性能优于冒泡排序
 * 最好、最坏、平均时间复杂度：O(n^2)
 * 空间复杂度：O(1)
 * 不稳定排序
 *
 * 思考：
 * 选择排序是否还有优化的空间？
 * - 使用堆来选择最大值
 *
 */
public class SelectionSort<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        for (int end = array.length - 1; end > 0; end--) {
            int max = 0;
            for (int begin = 1; begin <= end; begin++) {
                if (cmp(max, begin) < 0) {
                    max = begin;
                }
            }
            swap(max, end);
        }
    }
}
