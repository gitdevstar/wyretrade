extension anychart.enums {
    public enum StringToken: String {
        case ACTIVITY_INDEX = "%activityIndex"
        case AVERAGE = "%Average"
        case AXIS_NAME = "%AxisName"
        case AXIS_SCALE_MAX = "%AxisScaleMax"
        case AXIS_SCALE_MIN = "%AxisScaleMin"
        case BUBBLE_SIZE = "%BubbleSize"
        case BUBBLE_SIZE_PERCENT_OF_CATEGORY = "%BubbleSizePercentOfCategory"
        case BUBBLE_SIZE_PERCENT_OF_SERIES = "%BubbleSizePercentOfSeries"
        case BUBBLE_SIZE_PERCENT_OF_TOTAL = "%BubbleSizePercentOfTotal"
        case CATEGORY_NAME = "%CategoryName"
        case CATEGORY_Y_AVERAGE = "%CategoryYAverage"
        case CATEGORY_Y_MEDIAN = "%CategoryYMedian"
        case CATEGORY_Y_MODE = "%CategoryYMode"
        case CATEGORY_Y_PERCENT_OF_TOTAL = "%CategoryYPercentOfTotal"
        case CATEGORY_Y_RANGE_AVERAGE = "%CategoryYRangeAverage"
        case CATEGORY_Y_RANGE_MAX = "%CategoryYRangeMax"
        case CATEGORY_Y_RANGE_MEDIAN = "%CategoryYRangeMedian"
        case CATEGORY_Y_RANGE_MIN = "%CategoryYRangeMin"
        case CATEGORY_Y_RANGE_MODE = "%CategoryYRangeMode"
        case CATEGORY_Y_RANGE_PERCENT_OF_TOTAL = "%CategoryYRangePercentOfTotal"
        case CATEGORY_Y_RANGE_SUM = "%CategoryYRangeSum"
        case CATEGORY_Y_SUM = "%CategoryYSum"
        case CLOSE = "%Close"
        case CUMULATIVE_FREQUENCY = "%CF"
        case DATA_PLOT_BUBBLE_MAX_SIZE = "%DataPlotBubbleMaxSize"
        case DATA_PLOT_BUBBLE_MIN_SIZE = "%DataPlotBubbleMinSize"
        case DATA_PLOT_BUBBLE_SIZE_AVERAGE = "%DataPlotBubbleSizeAverage"
        case DATA_PLOT_BUBBLE_SIZE_SUM = "%DataPlotBubbleSizeSum"
        case DATA_PLOT_MAX_Y_SUM_SERIES_NAME = "%DataPlotMaxYSumSeriesName"
        case DATA_PLOT_MAX_Y_VALUE_POINT_NAME = "%DataPlotMaxYValuePointName"
        case DATA_PLOT_MAX_Y_VALUE_POINT_SERIES_NAME = "%DataPlotMaxYValuePointSeriesName"
        case DATA_PLOT_MIN_Y_SUM_SERIES_NAME = "%DataPlotMinYSumSeriesName"
        case DATA_PLOT_MIN_Y_VALUE_POINT_NAME = "%DataPlotMinYValuePointName"
        case DATA_PLOT_MIN_Y_VALUE_POINT_SERIES_NAME = "%DataPlotMinYValuePointSeriesName"
        case DATA_PLOT_POINT_COUNT = "%DataPlotPointCount"
        case DATA_PLOT_SERIES_COUNT = "%DataPlotSeriesCount"
        case DATA_PLOT_X_AVERAGE = "%DataPlotXAverage"
        case DATA_PLOT_X_MAX = "%DataPlotXMax"
        case DATA_PLOT_X_MIN = "%DataPlotXMin"
        case DATA_PLOT_X_SUM = "%DataPlotXSum"
        case DATA_PLOT_Y_AVERAGE = "%DataPlotYAverage"
        case DATA_PLOT_Y_MAX = "%DataPlotYMax"
        case DATA_PLOT_Y_MIN = "%DataPlotYMin"
        case DATA_PLOT_Y_RANGE_MAX = "%DataPlotYRangeMax"
        case DATA_PLOT_Y_RANGE_MIN = "%DataPlotYRangeMin"
        case DATA_PLOT_Y_RANGE_SUM = "%DataPlotYRangeSum"
        case DATA_PLOT_Y_SUM = "%DataPlotYSum"
        case END = "%end"
        case HIGH = "%High"
        case INDEX = "%Index"
        case LOW = "%Low"
        case MINUTES_PER_DAY = "%minutesPerDay"
        case NAME = "%Name"
        case OPEN = "%Open"
        case PERT_CHART_CRITICAL_PATH_STANDARD_DEVIATION = "%PertChartCriticalPathStandardDeviation"
        case PERT_CHART_PROJECT_DURATION = "%PertChartProjectDuration"
        case RANGE = "%Range"
        case RANGE_END = "%RangeEnd"
        case RANGE_START = "%RangeStart"
        case RELATIVE_FREQUENCY = "%RF"
        case RESOURCE_INDEX = "%resourceIndex"
        case SELECTED_POINTS_SUM = "%selectedPointsSum"
        case SERIES_BUBBLE_MAX_SIZE = "%SeriesBubbleMaxSize"
        case SERIES_BUBBLE_MIN_SIZE = "%SeriesBubbleMinSize"
        case SERIES_BUBBLE_SIZE_AVERAGE = "%SeriesBubbleSizeAverage"
        case SERIES_BUBBLE_SIZE_MEDIAN = "%SeriesBubbleSizeMedian"
        case SERIES_BUBBLE_SIZE_MODE = "%SeriesBubbleSizeMode"
        case SERIES_BUBBLE_SIZE_SUM = "%SeriesBubbleSizeSum"
        case SERIES_FIRST_X_VALUE = "%SeriesFirstXValue"
        case SERIES_FIRST_Y_VALUE = "%SeriesFirstYValue"
        case SERIES_LAST_X_VALUE = "%SeriesLastXValue"
        case SERIES_LAST_Y_VALUE = "%SeriesLastYValue"
        case SERIES_NAME = "%SeriesName"
        case SERIES_POINT_COUNT = "%SeriesPointCount"
        case SERIES_X_AVERAGE = "%SeriesXAverage"
        case SERIES_X_AXIS_NAME = "%SeriesXAxisName"
        case SERIES_X_MAX = "%SeriesXMax"
        case SERIES_X_MEDIAN = "%SeriesXMedian"
        case SERIES_X_MIN = "%SeriesXMin"
        case SERIES_X_MODE = "%SeriesXMode"
        case SERIES_X_SUM = "%SeriesXSum"
        case SERIES_Y_AVERAGE = "%SeriesYAverage"
        case SERIES_Y_AXIS_NAME = "%SeriesYAxisName"
        case SERIES_Y_MAX = "%SeriesYMax"
        case SERIES_Y_MEDIAN = "%SeriesYMedian"
        case SERIES_Y_MIN = "%SeriesYMin"
        case SERIES_Y_MODE = "%SeriesYMode"
        case SERIES_Y_RANGE_MAX = "%SeriesYRangeMax"
        case SERIES_Y_RANGE_MIN = "%SeriesYRangeMin"
        case SERIES_Y_RANGE_SUM = "%SeriesYRangeSum"
        case SERIES_Y_SUM = "%SeriesYSum"
        case START = "%start"
        case VALUE = "%Value"
        case X_PERCENT_OF_SERIES = "%XPercentOfSeries"
        case X_PERCENT_OF_TOTAL = "%XPercentOfTotal"
        case X_VALUE = "%XValue"
        case Y_PERCENT_OF_CATEGORY = "%YPercentOfCategory"
        case Y_PERCENT_OF_SERIES = "%YPercentOfSeries"
        case Y_PERCENT_OF_TOTAL = "%YPercentOfTotal"
        case Y_VALUE = "%YValue"

        public func getJsBase() -> String {
            return "'\(self.rawValue)'"
        }

    }

}