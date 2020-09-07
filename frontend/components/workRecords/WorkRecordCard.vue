<template lang="pug">
  v-card.pa-1
    v-form
      .work-record-card(v-if="readonly")
        v-card-title.goal-select(
        ) {{ propWorkRecord.goal_content }}
        .worked-for {{ propWorkRecord.formattedWorkTime() }}
        v-btn.edit-icon(
          @click="readonly = false"
          icon
        )
          v-icon edit
      .work-record-card(v-else)
        v-select.goal-select(
          v-model="workRecord.goal_id"
          :items="goalList"
          dense
          height="30"
          hide-details
        )
        // v-bind.sync の形式では javascript の式を使えない
        .worked-for
          .error-message(v-if="validationStart && !workTimeValid") 時間の計算が合いません
          worked-for-picker(
            v-bind:workTime="Number(workRecord.worked_for)"
            v-on:update:workTime="workRecord.worked_for = $event"
            :startTime="workRecord.start_time"
            :endTime="workRecord.end_time"
            :workTimeValid.sync="workTimeValid"
            :startTimeValid.sync="startTimeValid"
          )
        .worked-date
          .worked-on
            date-picker(
              v-bind:date="workRecord.momentDate()"
              v-on:update:date="emitUpdateDate($event)"
            )
          .start-time
            .error-message(v-if="validationStart && !startTimeValid") 終了時刻を超えています
            vue-timepicker(
              v-model="workRecord.start_time"
              auto-scroll
              hour-label="時"
              minute-label="分"
              placeholder="開始時刻"
            )
          .end-time
            vue-timepicker(
              v-model="workRecord.end_time"
              auto-scroll
              hour-label="時"
              minute-label="分"
              placeholder="終了時刻"
            )
        .memo
          v-textarea(
            v-model="workRecord.memo"
            label="メモ"
            auto-grow
            clearable
            counter="500"
            maxlength="500"
          )
        template(v-if="createMode")
          v-btn.cancel-button(
            @click="$emit('update:createMode', false)"
            color="grey"
            icon
          )
            v-icon backspace
          v-btn.post-button.pa-0.mt-5(
            @click="createWorkRecord"
            small
            color="success"
          ) 作成
        template(v-else)
          v-btn.cancel-button(
            @click="cancelEdit"
            icon
          )
            v-icon undo
          v-btn.post-button(
              @click="updateWorkRecord"
              small
              color="primary"
            ) 更新
</template>

<script lang="ts">
import Vue from 'vue';
import axios from 'axios';
import { api } from '@/config/api';
import { WorkRecord } from '@/models/workRecord';
import DatePicker from '@/components/workRecords/DatePicker.vue';
import WorkedForPicker from '@/components/workRecords/WorkedForPicker.vue';
import { Goal } from '@/models/goal';
import { VForm } from '@/plugins/vuetify';
import moment, { Moment } from 'moment';
import VueTimepicker from 'vue2-timepicker/src/vue-timepicker.vue';

interface Selector {
  value: string
  text:  string
}

export type Datatype = {
  workRecord:      WorkRecord
  readonly:        boolean
  workTimeValid:   boolean
  startTimeValid:  boolean
  validationStart: boolean
}

export default Vue.extend({
  props: {
    date:           { type: moment,     default: moment() },
    propWorkRecord: { type: WorkRecord, default: () => new WorkRecord() },
    createMode:     { type: Boolean, default: false },
  },
  data(): Datatype {
    return {
      workRecord:      new WorkRecord(),
      readonly:        true,
      workTimeValid:   true,
      startTimeValid:  true,
      validationStart: false,
    }
  },
  components: {
    DatePicker,
    WorkedForPicker,
    VueTimepicker,
  },
  created() {
    this.initialize();

    if (this.createMode) {
      this.readonly =false;
    }
  },
  computed: {
    userId(): string {
      return this.$store.getters.userId;
    },
    goalList(): Array<Selector> {
      return this.$store.getters.goalList.map((goal: Goal) => {
        return {
          value: goal.id,
          text:  goal.content
        };
      });
    },
    requestParams(): object {
      return {
        worked_on:  this.workRecord.worked_on,
        worked_for: this.workRecord.worked_for,
        start_time: this.workRecord.start_time,
        end_time:   this.workRecord.end_time,
        memo :      this.workRecord.memo,
        goal_id:    this.workRecord.goal_id
      }; 
    }
  },
  methods: {
    emitUpdateDate(moment: Moment): void {
      this.workRecord.worked_on = moment.format('YYYY-MM-DD');
    },
    initialize(): void {
      this.workRecord.id =         this.propWorkRecord.id;
      this.workRecord.worked_on =  this.date.format('YYYY-MM-DD');
      this.workRecord.worked_for = this.propWorkRecord.worked_for;
      this.workRecord.start_time = this.propWorkRecord.start_time;
      this.workRecord.end_time =   this.propWorkRecord.end_time;
      this.workRecord.memo =       this.propWorkRecord.memo;
      this.workRecord.goal_id =    this.propWorkRecord.goal_id;
    },
    cancelEdit(): void {
      this.initialize();
      this.workTimeValid = true;
      this.startTimeValid = true;
      this.validationStart = false;
      this.readonly = true;
    },
    createWorkRecord() {
      this.validationStart = true;
      if (!this.workTimeValid || !this.startTimeValid) return;

      axios.post(api.workRecordsPath(this.userId), { work_record: this.requestParams} )
        .then(response => {
          this.$emit('update:createMode', false);
          this.$emit('updateWorkRecordList');
        })
        .catch(error => {
          console.log(error.response);
        })
    },
    updateWorkRecord(): void {
      this.validationStart = true;
      if (!this.workTimeValid || !this.startTimeValid) return;

      axios.patch(api.workRecordPath(this.userId, this.workRecord.id), { work_record: this.requestParams} )
        .then(response => {
          this.readonly = true;
          this.$emit('updateWorkRecordList');
        })
        .catch(error => {
          console.log(error.response);
        })
    },
  }
})
</script>

<style lang="scss" scoped>
  .work-record-card {
    display: grid;
    grid-template-columns: 1fr 200px 64px;
    grid-row-gap: 10px;

    .goal-select {
      grid-area: 1/1/2/2;
      margin: auto 20px;
    }

    .worked-for {
      position: relative;
      grid-area: 1/2/2/3;
      margin: auto 30px auto auto;
    }

    .worked-date {
      grid-area: 2/1/3/3;
      grid-template-columns: repeat(auto-fill, 200px);
      display: grid;

      & > * {
        margin: auto;
      }

      .start-time {
        position: relative;
      }

      .end-time {
        &::before {
          content: '～';
          position: relative;
          top: 3px;
          left: -14px;
        }
      }
    }

    .edit-icon,
    .cancel-button {
      grid-area: 1/3/2/4;
      margin: 16px;
    }

    .post-button {
      grid-area: 2/3/3/4;
      padding: 0 !important;
      margin: auto 0;
    }

    .memo {
      grid-area: 3/1/4/2;
    }

    .error-message {
      color: #f00;
      position: absolute;
      top: -20px;
      font-size: 0.8em;
    }
  }
</style>
