export class User {
  id:               string;
  name:             string;
  password:         string;
  token:            string;
  is_admin:         boolean;
  is_private:       boolean;
  created_at:       string;
  updated_at:       string;

  constructor() {
    this.id =               '';
    this.name =             '';
    this.password =         '';
    this.token =            '',
    this.is_admin =         false;
    this.is_private =       false;
    this.created_at =       '';
    this.updated_at =       '';
  }

  setUserData(userData: any):void {
    this.id =               userData.id               || '';
    this.name =             userData.name             || '';
    this.token =            userData.token            || '';
    this.is_admin =         userData.is_admin         || false;
    this.is_private =       userData.is_private       || false;
    this.created_at =       userData.created_at       || '';
    this.updated_at =       userData.updated_at       || '';
  }

  // static methods
  
  static createIndexDataBy(dataList: Array<any>): Array<User> {
    const users: Array<User> = [];
    
    for (let i in dataList) {
      const user = new User();
      user.setUserData(dataList[i]);
      users.push(user);
    }

    return users;
  }

  // validation
  static getNameRules(): Array<(v: string) => boolean | string> {
    return [
      v => !!v || '名前は必須です',
      v => (v && v.length <= 20) || '名前は20文字以下で入力してください',
    ];
  }
  
  static getPasswordRules(): Array<(v: string) => boolean | string> {
    return [
      v => !!v || 'パスワードは必須です',
      v => (v && v.length >= 4 && v.length <= 20) || 'パスワードは4文字以上20文字以下で入力してください',
    ];
  }

  static getPasswordUpdateRules(): Array<(v: string) => boolean | string> {
    return [
      // 更新時はパスワードは空でもOK
      v => !v || (v.length >= 4 && v.length <= 20) || 'パスワードは4文字以上20文字以下で入力してください',
    ];
  }

}