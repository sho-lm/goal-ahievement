export class User {
  id!:               number;
  accountId!:        string;
  name!:             string;
  password!:         string;
  is_admin!:         boolean;
  is_private!:       boolean;
  created_at!:       string;
  updated_at!:       string;

  constructor() {
    this.initialize();
  }
  
  initialize(): void {
    this.id =               0;
    this.accountId =        '';
    this.name =             '';
    this.password =         '';
    this.is_admin =         false;
    this.is_private =       false;
    this.created_at =       '';
    this.updated_at =       '';
  }

  setResponse(response: any):void {
    this.id =               response.id               || 0;
    this.accountId =        response.account_id       || '';
    this.name =             response.name             || '';
    this.password =         response.password         || '';
    this.is_admin =         response.is_admin         || false;
    this.is_private =       response.is_private       || false;
    this.created_at =       response.created_at       || '';
    this.updated_at =       response.updated_at       || '';
  }
  
  static createIndexDataBy(response: Array<any>): Array<User> {
    const users: Array<User> = [];
    
    for (let i in response) {
      const user = new User();
      user.setResponse(response[i]);
      users.push(user);
    }

    return users;
  }
}