package com.key.sort.cmp;

import com.key.sort.Sort;

/**
 * 快速排序 - 执行流程
 * - 从序列中选择一个轴点元素 pivot
 *   - 假设每次选择0位置的元素为轴点元素
 * - 利用pivot将序列分割成2个子序列
 *   - 将小于pivot的元素放在pivot前面(左侧)
 *   - 将大于pivot的元素放在pivot后面(右侧)
 * - 对子序列惊醒以上操作
 *   - 直到不能再分割(子序列中只剩下1个元素)
 *
 * 快速排序的本质：
 *  - 逐渐将每一个元素都转换成轴点元素
 *
 */
public class QuickSort<E extends Comparable<E>> extends Sort<E> {

    @Override
    protected void sort() {
        sort(0, array.length);
    }

    /**
     * 对 [begin, end) 范围的元素进行快速排序
     */
    private void sort(int begin, int end) {
        if (end - begin < 2) return;
        // 确定轴点元素的位置
        int pivotIndex = pivotIndex(begin, end);
        // 对子序列进行快速排序
        sort(begin, pivotIndex);
        sort(pivotIndex + 1, end);
    }

    /**
     * 构造出 [begin, end) 范围的轴点元素
     * @return 轴点元素的最终位置
     */
    private int pivotIndex(int begin, int end) {

        // 随机选择一个元素跟begin位置进行交换 - 防止最坏情况的出现
        swap(begin, begin + (int)(Math.random() * (end - begin)));

        // 备份begin位置元素
        E pivot = array[begin];
        // end需要指向最后一个元素，这里做--操作
        end--;

        while (begin < end) {
            // 从右向左
            while (begin < end) {
                // 右边元素 > 轴点元素
                if (cmp(pivot, array[end]) < 0) {
                    end--;
                } else { // 右边元素 <= 轴点元素
                    array[begin++] = array[end];
                    break;
                }
            }
            // 从左向右
            while (begin < end) {
                // 左边元素 < 轴点元素
                if (cmp(pivot, array[begin]) > 0) {
                    begin++;
                } else { // 左边元素 >= 轴点元素
                    array[end--] = array[begin];
                    break;
                }
            }
        }

        // 说明begin == end，因为begin和end都是单一方的++或--，到这里必然相等
        // 将轴点原色放入最终的位置
        array[begin] = pivot;
        // 返回轴点元素的位置
        return begin;
    }
}
