package com.key.sort;

import java.text.DecimalFormat;

/**
 * 排序均以升序为例
 */
public abstract class Sort<E extends Comparable<E>> implements Comparable<Sort<E>> {
    protected E[] array;

    private int cmpCount;
    private int swapCount;
    private long time;
    private DecimalFormat fmt = new DecimalFormat("#.00");

    public void sort(E[] array) {
        if (array == null || array.length < 2) return;
        this.array = array;

        long beginTime = System.currentTimeMillis();
        sort();
        time = System.currentTimeMillis() - beginTime;
    }

    @Override
    public int compareTo(Sort<E> o) {
        int result = (int)(time - o.time);
        if (result != 0) return result;

        result = cmpCount - o.cmpCount;
        if (result != 0) return result;

        return swapCount - o.swapCount;
    }

    /**
     * 子类实现排序
     */
    protected abstract void sort();

    /**
     * 根据索引比较两个元素大小
     * @return
     * 返回值 = 0 : array[i1] = array[i2]
     * 返回值 > 0 : array[i1] > array[i2]
     * 返回值 < 0 : array[i1] < array[i2]
     */
    protected int cmp(int i1, int i2) {
        cmpCount ++;
        return array[i1].compareTo(array[i2]);
    }

    /**
     * 根据值比较两个元素大小
     * @return
     * 返回值 = 0 : array[i1] = array[i2]
     * 返回值 > 0 : array[i1] > array[i2]
     * 返回值 < 0 : array[i1] < array[i2]
     */
    protected int cmp(E v1, E v2) {
        cmpCount ++;
        return v1.compareTo(v2);
    }

    /**
     * 根据索引交换两个位置的值
     */
    protected void swap(int i1, int i2) {
        swapCount ++;
        E tmp = array[i1];
        array[i1] = array[i2];
        array[i2] = tmp;
    }

    @Override
    public String toString() {
        String timeStr = "耗时：" + (time / 1000.0) + "s(" + time + "ms)";
        String compareCountStr = "比较：" + numberString(cmpCount);
        String swapCountStr = "交换：" + numberString(swapCount);
        String stableStr = "稳定性" + isStable();
        return "【" + getClass().getSimpleName() + "】\n"
                + stableStr + "\t"
                + timeStr + " \t"
                + compareCountStr + "\t "
                + swapCountStr + "\n"
                + "------------------------------------------------------------------" + "\n";
    }

    private String numberString(int number) {
        if (number < 10000) return "" + number;

        if (number < 100000000) return fmt.format(number / 10000.0) + "万";
        return fmt.format(number / 100000000.0) + "亿";
    }

    /**
     * 算法的稳定性
     * - 如果相等的2个元素，在排序前后的相对位置保持不变，那么这是稳定的排序算法
     */
    private boolean isStable() {

        Student[] students = new Student[20];
        for (int i = 0; i < students.length; i++) {
            students[i] = new Student(i*10, 10);
        }
        sort((E[])students);
        for (int i = 1; i < students.length; i++) {
            int score = students[i].score;
            int preScore = students[i - 1].score;
            if (preScore + 10 != score) {
                return false;
            }
        }
        return true;
    }
}
