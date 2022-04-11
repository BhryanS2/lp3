<?php
class Search
{
    public $array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    public $key = 5;
    public $low = 0;
    public $high = 0;
    public $mid = 0;

    public function binarySearch($array, $key)
    {
        if (count($array) == 0) {
            $array = $this->array;
        }
        $this->low = 0;
        $this->high = count($array) - 1;
        while ($this->low <= $this->high) {
            $this->mid = floor(($this->low + $this->high) / 2);
            if ($array[$this->mid] == $key) {
                return $this->mid;
            } else if ($array[$this->mid] < $key) {
                $this->low = $this->mid + 1;
            } else {
                $this->high = $this->mid - 1;
            }
        }
        return -1;
    }

    public function linearSearch($array, $key)
    {
        if (count($array) == 0) {
            $array = $this->array;
        }

        for ($i = 0; $i < count($array); $i++) {
            if ($array[$i] == $key) {
                return $i;
            }
        }
        return -1;
    }

    public function binarySearchRecursive($array, $key, $low, $high)
    {
        if (count($array) == 0) {
            $array = $this->array;
        }
        if ($low <= $high) {
            $mid = floor(($low + $high) / 2);
            if ($array[$mid] == $key) {
                return $mid;
            } else if ($array[$mid] < $key) {
                return $this->binarySearchRecursive($array, $key, $mid + 1, $high);
            } else {
                return $this->binarySearchRecursive($array, $key, $low, $mid - 1);
            }
        }
        if ($this . $array == 0) {
            return -1;
        }

        if ($this->low <= $this->high) {
            $this->mid = floor(($this->low + $this->high) / 2);
            if ($array[$this->mid] == $key) {
                return $this->mid;
            } else if ($array[$this->mid] < $key) {
                return $this->binarySearchRecursive($array, $key, $this->mid + 1, $this->high);
            } else {
                return $this->binarySearchRecursive($array, $key, $this->low, $this->mid - 1);
            }
        }
        return -1;
    }
}
