new Vue({
    el: '#schedule-meeting',
    data: {
        title: '',
        start_date: '',
        end_date: '',
        start_time: '',
        end_time: '',
        all_day: false,
        repeat_weekly: false,
        repeat_day: 0,
        mute_video: false,
        mute_audio: false,
        record_meeting: false,
        description: '',
        event_tags: [],
        notification_type: 'Email',
        notification_minutes: 10,
        guests: [],
        guest_name: '',
        guest_permissions: [],
        everyone_as_admin: false,
        modify_meeting: false,
        invite_others: false,
        see_guest_list: false
    },
    methods: {
        handleSubmit() {
            let authenticity_token = $('#authenticity_token').val();
            axios.post('/schedules/store', {
                authenticity_token: authenticity_token,
                title: this.title,
                start_date: this.start_date,
                end_date: this.end_date,
                start_time: this.start_time,
                end_time: this.end_time,
                all_day: this.all_day,
                repeat_weekly: this.repeat_weekly,
                repeat_day: this.repeat_day,
                mute_video: this.mute_video,
                mute_audio: this.mute_audio,
                record_meeting: this.record_meeting,
                description: this.description,
                event_tags: this.event_tags,
                notification_type: this.notification_type,
                notification_minutes: this.notification_minutes,
                guests: this.guests,
                guest_permissions: {
                    everyone_as_admin: this.everyone_as_admin,
                    modify_meeting: this.modify_meeting,
                    invite_others: this.invite_others,
                    see_guest_list: this.see_guest_list
                }
            })
                .then(res => {
                    window.location.reload();
                })
                .catch(error => console.error(error))
        },
        handleAddGuest() {
            if (this.guest_name) {
                this.guests.push(this.guest_name);
                this.guest_name = ''
            }
        },
        removeGuest(index) {
            this.guests.splice(index, 1)
        }
    }
})