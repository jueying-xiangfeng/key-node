package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 堆排序：
 * 可认为是对选择排序的一种优化
 *
 * 执行流程：
 * - 对序列进行原地建堆 (heapify)
 * - 重复以下操作，直到堆的元素数量为1
 *   - 交换堆顶与堆尾元素
 *   - 堆的元素数量减1
 *   - 对0位置进行一次下滤(Sift Down)操作
 *
 * 最好、最坏、平均时间复杂度：O(n*logn)
 * 空间复杂度：O(1)
 * 不稳定排序
 *
 */
public class HeapSort<E extends Comparable<E>> extends Sort<E> {

    private int heapSize;

    @Override
    protected void sort() {
        heapSize = array.length;

        // 原地建堆 (自下而上的下滤) 从最后一个非叶子开始执行下滤操作
        for (int i = (heapSize >> 1) - 1; i >= 0; i--) {
            siftDown(i);
        }

        // 交换堆顶与尾部元素，然后对新的堆顶执行一次下滤操作，保证堆的性质
        while (heapSize > 1) {
            swap(0, --heapSize);
            siftDown(0);
        }
    }

    private void siftDown(int index) {
        E element = array[index];

        // 这里 index 必须为非叶子节点: n/2-1
        int half = heapSize >> 1;
        while (index < half) {
            // 默认先取左子节点 2n + 1
            int childIndex = (index << 1) + 1;
            E childElement = array[childIndex];

            // 再取右子节点 2n + 2
            // 如果 右子节点 > 左子节点，则取较大的右子节点
            int rightChildIndex = childIndex + 1;
            if (rightChildIndex < heapSize && cmp(childElement, array[rightChildIndex]) < 0) {
                childElement = array[childIndex = rightChildIndex];
            }

            // 比较 element 与较大子节点的大小
            if (cmp(element, childElement) >= 0) return;

            array[index] = childElement;
            index = childIndex;
        }
        array[index] = element;
    }
}
