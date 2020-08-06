export class WorkRecord {
  id:           string
  content:      string
  worked_on:    string
  worked_for:   string
  start_time:   string
  end_time:     string
  user_id:      string
  goal_id:      string
  category_id:  number
  created_at:   string
  updated_at:   string

  constructor() {
    this.id =           '';
    this.content =      '';
    this.worked_on =    '';
    this.worked_for =   '';
    this.start_time =   '';
    this.end_time =     '';
    this.user_id =      '';
    this.goal_id =      '';
    this.category_id =  0;
    this.created_at =   '';
    this.updated_at =   '';
  }

  setWorkRecordData(workRecordData: any): void {
    this.id = workRecordData.id                   || '';
    this.content = workRecordData.content         || '';
    this.worked_on = workRecordData.worked_on     || '';
    this.worked_for = workRecordData.worked_for   || '';
    this.start_time = workRecordData.start_time   || '';
    this.end_time = workRecordData.end_time       || '';
    this.user_id = workRecordData.user_id         || '';
    this.goal_id = workRecordData.goal_id         || '';
    this.category_id = workRecordData.category_id || 0;
    this.created_at = workRecordData.created_at   || '';
    this.updated_at = workRecordData.updated_at   || '';
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