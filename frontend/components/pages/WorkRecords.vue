<template lang="pug">
  div
    .work-records-header.page-header
      .page-title 勉強記録
      .date-selector(v-if="!deleteMode")
        date-picker(
          :date.sync="requestDate"
          showArrow
        )
      .delete-mode-area(v-else)
        v-btn.all-uncheck-button(
          @click="uncheckAll"
          icon
        )
          v-icon check_box_outline_blank
        v-btn.all-check-button(
          @click="checkAll"
          color="red"
          icon
        )
          v-icon check_box
        v-btn.delete-button(
          @click="deleteWorkRecords"
          color="red"
          icon
        )
          v-icon delete
      v-btn.delete-mode-button(
        @click="changeDeleteMode"
        icon
      )
        v-icon(
          large
        ) {{ deleteModeIcon }}
      v-btn.add-mode-button(
        color="primary"
        @click="createMode = !createMode"
        icon
      )
        v-icon(
          large
        )  {{ createModeIcon }}
      v-divider.divider
      template(v-if="createMode")
        .new-work-record
          p 新規作成
          work-record-card(
            :date="requestDate"
            :createMode.sync="createMode"
            @updateWorkRecordList="selectWorkRecordList"
          )
        v-divider.divider-create-mode
    section.pa-6
      .work-record-item(
        v-for="workRecord in workRecordList"
        :key="workRecord.id"
        :style="{ 'grid-template-columns': `${checkboxWidth}px 1fr` }"
      )
        v-checkbox.mt-5(
          v-model="workRecord.deleteCheckBox"
          dense
          color="red"
        )
        work-record-card.mb-1(
          :date="requestDate"
          :propWorkRecord="workRecord"
          @updateWorkRecordList="selectWorkRecordList"
        )
</template>

<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { api } from '@/config/api';
import { WorkRecord } from '@/models/workRecord';
import { Goal } from '@/models/goal';
import WorkRecordCard from '@/components/workRecords/WorkRecordCard.vue';
import DatePicker from '@/components/common/DatePicker.vue';
import moment, { Moment } from 'moment';

export type DataType = {
  workRecordList:  Array<WorkRecord>
  requestDate:     Moment
  deleteMode:      boolean
  createMode:      boolean
}

const dateFormat = 'yyyy-M-D';

export default Vue.extend({
  data(): DataType {
    return {
      workRecordList: [],
      requestDate:    moment(),
      deleteMode:     false,
      createMode:     false,
    }
  },
  components: {
    WorkRecordCard,
    DatePicker
  },
  created() {
    this.selectWorkRecordList();
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    },
    deleteModeIcon(): string {
      return this.deleteMode ? 'undo' : 'remove_circle_outline';
    },
    createModeIcon(): string {
      return this.createMode ? 'undo' : 'playlist_add';
    },
    checkboxWidth(): number {
      return this.deleteMode ? 40 : 0;
    },
    deleteList(): Array<WorkRecord> {
      return this.workRecordList.filter((workRecord: WorkRecord) => workRecord.deleteCheckBox);
    },
  },
  watch: {
    requestDate() {
      this.selectWorkRecordList();
      this.createMode = false;
    }
  },
  methods: {
    changeDeleteMode(): void {
      this.deleteMode = !this.deleteMode;
      if (!this.deleteMode) {
        this.uncheckAll();
      }
    },
    uncheckAll(): void {
      for (let goal of this.workRecordList) {
        goal.deleteCheckBox = false;
      }
    },
    checkAll(): void {
      for (let goal of this.workRecordList) {
        goal.deleteCheckBox = true;
      }
    },
    selectWorkRecordList(): void {
      const params = {
        date: this.requestDate.format("YYYY-MM-DD")
      };
      axios.get(api.workRecordsPath(this.userId), { params: params })
        .then(response => {
          this.workRecordList = WorkRecord.createIndexDataBy(response.data);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    deleteWorkRecords(): void {
      const deleteIdList = [];
      for (let workRecord of this.deleteList) {
        deleteIdList.push(workRecord.id);
      }
      const params = {
        ids: deleteIdList
      }
      axios.delete(api.workRecordMultiplePath(this.userId), { params })
        .then(response => {
          this.selectWorkRecordList();
        })
        .catch(error => {
          console.log(error.response);
        })
    }
  }
})
</script>

<style lang="scss" scoped>
  .work-records-header {
    display: grid;
    grid-template-columns: 130px minmax(300px, 1fr) 100px 100px;

    .page-title {
      grid-area: 1/1/2/2;
      margin: 15px 10px;
      font-weight: bold;
    }

    .date-selector {
      grid-area: 1/2/2/3;
      margin-top: 5px;
      width: 300px;
    }

    .delete-mode-area {
      width: 300px;
      border: 1px solid rgba(0, 0, 0, 0.2);
      border-radius: 20px;
      display: grid;
      grid-area: 1/2/2/3;
      height: 40px;
      margin: auto 30px auto auto;

      .all-uncheck-button {
        grid-area: 1/2/2/3;
      }
      .all-check-button {
        grid-area: 1/3/2/4;
      }
      .delete-button {
        grid-area: 1/4/2/5;
      }
    }

    .delete-mode-button {
      grid-area: 1/3/2/4;
      margin: auto;
    }
    .add-mode-button {
      grid-area: 1/4/2/5;
      margin: auto;
    }
    .divider {
      grid-area:2/1/2/5;
    }

    .new-work-record {
      grid-area: 2/1/3/5;
      padding: 24px;
    }
    .divider-create-mode {
      grid-area: 3/1/3/5;
    }
  }

  .work-record-item {
    display: grid;
  }
</style>
