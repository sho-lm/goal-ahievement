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
  
  static createIndexDataBy(dataList: Array<any>): Array<User> {
    const users: Array<User> = [];
    
    for (let i in dataList) {
      const user = new User();
      user.setUserData(dataList[i]);
      users.push(user);
    }

    return users;
  }
}