package com.utils {
    import starling.display.DisplayObject;
    import starling.filters.ColorMatrixFilter;


    /**
     * 颜色，滤镜工具
     * @author Samuel
     *
     */
    public class FilterUtils {

        /**
         * 创建矩阵滤镜(基于Flash软件参数);
         * @param disObject
         * @param brightness 亮度    取值为-100到100
         * @param contrast   对比度取值为-100到100
         * @param saturation 饱和度取值为-100到100
         * @param hue		   色相    取值为-180到180
         * @param threshold  阈值    取值为   0到1
         */
        public static function colorMatrixFilter(disObject:DisplayObject, brightness:Number = 0, contrast:Number = 0, saturation:Number = 0,
                                                 hue:Number = 0, threshold:Number = 1):void {
            var colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter();
            colorMatrixFilter.adjustBrightness(brightness / 100);
            colorMatrixFilter.adjustContrast(contrast / 100);
            colorMatrixFilter.adjustSaturation(saturation / 100);
            colorMatrixFilter.adjustHue(hue / 180);
            disObject.alpha = threshold;
            disObject.filter = colorMatrixFilter;
        }

    }
}
