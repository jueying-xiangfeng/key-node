package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 执行流程：
 * - 不断地将当前序列平均分割成2个子序列
 *   - 直到不能再分割 (序列中只剩1个元素)
 * - 不断地将2个子序列合并成一个有序序列
 *   - 直到最终只剩1个有序序列
 *
 */
public class MergeSort<E extends Comparable<E>> extends Sort<E> {
    private E[] leftArray;

    @Override
    protected void sort() {
        leftArray = (E[]) new Comparable[array.length >> 1];
        sort(0, array.length);
    }

    /**
     * 对 [begin, end) 范围的数据进行归并排序
     */
    private void sort(int begin, int end) {
        if (end - begin < 2) return;

        int middle = (end + begin) >> 1;
        sort(begin, middle);
        sort(middle, end);
        merge(begin, middle, end);
    }

    /**
     * 将 [begin, middle)，[middle, end) 范围的序列合并成一个有序序列
     */
    private void merge(int begin, int middle, int end) {
        int li = 0, le = middle - begin;
        int ri = middle, re = end;
        int ai = begin;

        // 备份左边数组
        for (int i = li; i < le; i++) {
            leftArray[i] = array[begin + i];
        }

        // 如果左边还没结束
        while (li < le) {
            if (ri < re && cmp(array[ri], leftArray[li]) < 0) {
                array[ai++] = array[ri++];
            } else {
                array[ai++] = leftArray[li++];
            }
        }
    }
}
