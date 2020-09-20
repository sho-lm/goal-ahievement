export class Goal {
  id:               string
  content:          string
  color:            string
  is_finished:      boolean
  user_id:          string
  created_at:       string
  updated_at:       string
  deleteCheckBox:   boolean
  filterCheck:      boolean

  constructor() {
    this.id =               '';
    this.content =          '';
    this.color =            '';
    this.is_finished =      false;
    this.user_id =          '';
    this.created_at =       '';
    this.updated_at =       '';
    this.deleteCheckBox =   false;
    this.filterCheck =      true;
  }

  setGoalData(goalData: any):void {
    this.id = goalData.id                             || '';
    this.content = goalData.content                   || '';
    this.color = goalData.color                       || '';
    this.is_finished = goalData.is_finished           || false;
    this.user_id = goalData.user_id                   || '';
    this.created_at = goalData.created_at             || '';
    this.updated_at = goalData.updated_at             || '';
  }
  
  static createIndexDataBy(dataList: Array<any>): Array<Goal> {
    const goals: Array<Goal> = [];
    
    for (let i in dataList) {
      const goal = new Goal();
      goal.setGoalData(dataList[i]);
      goals.push(goal);
    }
    return goals;
  }

  // validation
  static getContentRules(): Array<(v: string) => boolean | string> {
    return [
      v => !!v || '目標内容は必須です',
      v => (v && v.length <= 20) || '目標内容は20文字以下で入力してください',
    ];
  }
}
