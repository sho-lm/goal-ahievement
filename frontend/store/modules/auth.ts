interface Auth {
  id:    string
  token: string
}

export const auth = {
  state: {
    id:    '',
    token: ''
  },
  getters: {
    auth: (state: any): Auth => ({ id: state.id, token: state.token }),
    userId: (state: any): string => state.id
  },
  mutations: {
    setAuth(state: any, auth: Auth): void {
      state.id = auth.id;
      state.token = auth.token;
    }
  },
  actions: {
    discardAuth(context: any): void {
      context.commit('setAuth', { id: null, token: null});
    }
  }
}