export const snackbar = {
  state: {
    snackbarDisplay: false,
    snackbarMessage: '',
  },
  getters: {
    snackbarDisplay: (state: any): boolean => state.snackbarDisplay,
    snackbarMessage: (state: any): string => state.snackbarMessage,
  },
  mutations: {
    setSnackbarDisplay(state: any, snackbarDisplay: boolean): void {
      state.snackbarDisplay = snackbarDisplay;
    },
    setSnackbarMessage(state: any, snackbarMessage: string): void {
      state.snackbarMessage = snackbarMessage;
    },
  },
  actions: {
    hideMessage(context: any): void {
      context.commit('setSnackbarMessage', '');
      context.commit('setSnackbarDisplay', false);
    },
    showMessage(context: any, message: string): void {
      context.commit('setSnackbarMessage', message);
      context.commit('setSnackbarDisplay', true);
    }
  }
}
