import moment, { Moment } from 'moment';

moment.locale("ja");

export const reports = {
  state: {
    reportDate:       moment(),
    reportType:       'time',
    reportFilterList: null,
  },
  getters: {
    reportDate: (state: any): Moment => state.reportDate,
    reportType: (state: any): string => state.reportType,
    reportFilterList: (state: any): Array<string> => state.reportFilterList
  },
  mutations: {
    setReportDate(state: any, reportDate: Moment): void {
      state.reportDate = reportDate;
    },
    setReportType(state: any, reportType: string): void {
      state.reportType = reportType;
    },
    setReportFilterList(state: any, reportFilterList: Array<string>): void {
      state.reportFilterList = reportFilterList;
    }
  },
}