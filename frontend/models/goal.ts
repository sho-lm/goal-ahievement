export class Goal {
    id:               string
    content:          string
    limit:            string
    achievement_flag: boolean
    progress:         number
    order_number:     number
    hierarchy:        number
    children_length:  number
    user_id:          string
    parent_id:        string
    created_at:       string
    updated_at:       string

    constructor() {
      this.id =               '';
      this.content =          '';
      this.limit =            '';
      this.achievement_flag = false;
      this.progress =         0;
      this.order_number =     0;
      this.hierarchy =        0;
      this.children_length =  0;
      this.user_id =          '';
      this.parent_id =        '';
      this.created_at =       '';
      this.updated_at =       '';
    }

    setGoalData(goalData: any):void {
      this.id = goalData.id                             || '';
      this.content = goalData.content                   || '';
      this.limit = goalData.limit                       || '';
      this.achievement_flag = goalData.achievement_flag || false;
      this.progress = goalData.progress                 || 0;
      this.order_number = goalData.order_number         || 0;
      this.hierarchy = goalData.hierarchy               || 0;
      this.children_length = goalData.children_length   || 0;
      this.user_id = goalData.user_id                   || '';
      this.parent_id = goalData.parent_id               || '';
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
}