/* eslint-disable no-param-reassign */
import { createSlice } from '@reduxjs/toolkit';
import { actions as checkInfoActions } from './checkInfoSlice.js';
import { currentTabStates } from '../utils/stateMachines.js';

export const sliceName = 'tabsBoxSlice';

const slice = createSlice({
  name: sliceName,
  initialState: {
    currentTab: currentTabStates.editor,
  },
  reducers: {
    changeTab(state, { payload }) {
      state.currentTab = payload.newTabState;
    },
  },
  extraReducers: {
    [checkInfoActions.runCheck.pending](state) {
      state.currentTab = currentTabStates.console;
    },
  },
});

export const { actions } = slice;

export default slice.reducer;
