import moment, { Moment } from 'moment';

export class WorkRecord {
  id:             string
  memo:           string
  worked_on:      string
  worked_for:     string
  start_time:     string
  end_time:       string
  user_id:        string
  goal_id:        string
  goal_content:   string
  created_at:     string
  updated_at:     string
  deleteCheckBox: boolean

  constructor() {
    this.id =             '';
    this.memo =           '';
    this.worked_on =      '';
    this.worked_for =     '';
    this.start_time =     '';
    this.end_time =       '';
    this.user_id =        '';
    this.goal_id =        '';
    this.goal_content =   '';
    this.created_at =     '';
    this.updated_at =     '';
    this.deleteCheckBox = false;
  }

  setWorkRecordData(workRecordData: any): void {
    this.id = workRecordData.id                     || '';
    this.memo = workRecordData.memo                 || '';
    this.worked_on = workRecordData.worked_on       || '';
    this.worked_for = workRecordData.worked_for     || '0';
    this.start_time = workRecordData.start_time     || '';
    this.end_time = workRecordData.end_time         || '';
    this.user_id = workRecordData.user_id           || '';
    this.goal_id = workRecordData.goal_id           || '';
    this.goal_content = workRecordData.goal_content || '設定なし';
    this.created_at = workRecordData.created_at     || '';
    this.updated_at = workRecordData.updated_at     || '';
  }

  formattedWorkTime(): string {
    const time = Number(this.worked_for);
    const h = Math.trunc(time / 60);
    const m = time % 60;
    let formattedTime = '';
    if (h) {
      formattedTime += `${h}時間`;
    } 
    if (m) {
      formattedTime += `${m}分`;
    }
    return formattedTime;
  }

  momentDate(): Moment {
    return moment(this.worked_on);
  }

  static createIndexDataBy(dataList: Array<any>): Array<WorkRecord> {
    const workRecords: Array<WorkRecord> = [];
    
    for (let i in dataList) {
      const workRecord = new WorkRecord();
      workRecord.setWorkRecordData(dataList[i]);
      workRecords.push(workRecord);
    }

    return workRecords;
  }
}
