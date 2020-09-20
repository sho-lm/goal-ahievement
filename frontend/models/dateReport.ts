interface Axis {
  x: number
  y: string
}

interface Datasets {
  label:           string
  data:            Array<number>
  backgroundColor: string
  barPercentage:   number
}

export class DateReport {
  labels:   Array<string>
  datasets: Array<Datasets>

  constructor(reportData: any, start: string, end: string) {

    console.log(reportData);
    // labels 作成
    this.labels = [
      "2020-09-01",
      "2020-09-02",
      "2020-09-03",
      "2020-09-04",
      "2020-09-05",
      "2020-09-06",
      "2020-09-07",
      "2020-09-08",
      "2020-09-09",
      "2020-09-10",
      "2020-09-11",
      "2020-09-12",
      "2020-09-13",
      "2020-09-14",
      "2020-09-15",
      // "2020-09-16",
      // "2020-09-17",
      // "2020-09-18",
      // "2020-09-19",
      // "2020-09-20",
      // "2020-09-21",
      // "2020-09-22",
      // "2020-09-23",
      // "2020-09-24",
      // "2020-09-25",
      // "2020-09-26",
      // "2020-09-27",
      // "2020-09-28",
      // "2020-09-29",
      // "2020-09-30",
    ];
    
    // datasets 作成
    this.datasets = [];
    const dataLen = reportData.length;
    let prevId = -1;
    let dataset: any = {};

    for (let i = 0; i < dataLen; i++) {
      const id = reportData[i].goal_id || 0;

      if (prevId !== id) {
        dataset = {
          label:           reportData[i].content || '設定なし',
          backgroundColor: reportData[i].color   || '#bbb',
          barPercentage:   0.5,
          data:            []
        };
        this.datasets.push(dataset);
      }

      const axis = {
        x: reportData[i].sum_work_records / 60,
        y: reportData[i].worked_on
      };
      dataset.data.push(axis);
      prevId = id;
    }
  }
}