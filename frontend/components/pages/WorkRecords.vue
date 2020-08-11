<template lang="pug">
  #users
    div(v-if="$store.getters.isLoggedIn")
      section.new-work-record
        p new work record
        label(for="content") content
        input(v-model="content")
        label(for="workedOn") worked on
        input(v-model="workedOn", type="date")
        button(@click="postCreate") create

      section.update-work-record(v-if="isEditMode")
        label(for="content") content
        input(v-model="contentCopy")
        label(for="workedOn") workedOn
        input(v-model="workedOnCopy", type="date")
        button(@click="patchUpdate") update
        button(@click="deleteDestroy") delete
        button(@click="cancelEditMode") cancel

      section.work-records
        h3 work records data
        .work-record-item(v-for="workRecord in workRecordList")
          p content: {{ workRecord.content }}
          p workedOn: {{ workRecord.worked_on }}
          button(@click="changeEditMode(workRecord, $event)") edit mode
    div(v-else)
      p need log in
</template>
<script lang="ts">
import Vue from 'vue'
import axios from 'axios';
import { WorkRecord } from '@/models/workRecord';
import { api } from '@/config/api';

export type DataType = {
  workRecordList: Array<WorkRecord>
  content:        string
  workedOn:       string
  contentCopy:    string
  workedOnCopy:   string
  workRecordId:   string
  isEditMode:     boolean
}


export default Vue.extend({
  data(): DataType {
    return {
      workRecordList: [],
      content:        '',
      workedOn:       '',
      contentCopy:    '',
      workedOnCopy:   '',
      workRecordId:   '',
      isEditMode:     false,
    }
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    }
  },
  watch: {
    userId() {
      this.selectWorkRecordList();
    }
  },
  mounted() {
    this.selectWorkRecordList();
  },
  methods: {
    changeEditMode(workRecord: WorkRecord, event: any): void {
      this.contentCopy = workRecord.content;
      this.workedOnCopy = workRecord.worked_on; 
      this.workRecordId = workRecord.id;
      this.isEditMode = true;
    },
    cancelEditMode(): void {
      this.isEditMode = false;
    },
    selectWorkRecordList(): void {
      axios.get(api.workRecordsPath(this.userId))
        .then(response => {
          this.workRecordList = WorkRecord.createIndexDataBy(response.data);
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    postCreate(): void {
      const params = {
        content: this.content,
        worked_on: this.workedOn
      };
      axios.post(api.workRecordsPath(this.userId), { work_record: params })
        .then(response => {
          const workRecord = new WorkRecord();
          workRecord.setWorkRecordData(response.data);
          this.workRecordList.push(workRecord);
          this.content = '';
          this.workedOn = '';
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    patchUpdate(): void {
      const params = {
        content: this.contentCopy,
        worked_on: this.workedOnCopy
      };
      axios.patch(api.workRecordPath(this.userId, this.workRecordId), { work_record: params })
        .then(response => {
          this.isEditMode = false;
          this.selectWorkRecordList();
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    deleteDestroy(): void {
      axios.delete(api.workRecordPath(this.userId, this.workRecordId))
        .then(response => {
          this.isEditMode = false;
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
  .new-work-record {
    display: grid;
    gap: 5px;
    border: 1px solid rgb(101, 200, 123);
    padding: 10px;
  }
  .update-work-record {
    margin-top: 10px;
    display: grid;
    gap: 5px;
    border: 1px solid rgb(184, 230, 35);
    padding: 10px;
  }
  .work-record-item {
    border-bottom: 1px solid rgb(119, 110, 240);
  }
</style>