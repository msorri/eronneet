<template>
    <div id="app" class="container mx-auto py-10">
        <div class="sm:flex sm:items-center px-6 py-4 w-full">
            <div class="text-center font-serif sm:flex-grow">
                <div class="mb-6">
                    <p class="text-2xl leading-tight">Kirkosta on eronnut</p>
                </div>
                <div class="flex flex-row items-stretch items-end content-start">
                    <div class="flex-1">
                        <p class="inline text-xl leading-tight">tänään</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">
                            <IOdometer class="m-0" :value="resignedToday"></IOdometer>
                        </p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                    <div class="flex-1">
                        <p class="inline text-xl leading-tight">tällä viikolla</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">{{ resignedThisWeek }}</p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                    <div class="flex-1">
                        <p class="inline text-xl leading-tight">tässä kuussa</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">{{ resignedThisMonth }}</p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
    .odometer-inside {
        display: inline;
    }
</style>

<script>
    import IOdometer from 'vue-odometer';
    import 'odometer/themes/odometer-theme-default.css';
    import axios from 'axios';
    import moment from 'moment';

    export default {
        name: 'index',
        components: {
            IOdometer
        },
        data() {
            return {
                resignedToday: 1,
                resignedThisWeek: 2,
                resignedThisMonth: 3
            }
        },
        mounted() {
            axios
                .get('http://www.eroakirkosta.fi/dynamic/tilastot.php?start=01.06.2019&end=31.06.2019&accumulate=false')
                .then(response => (this.resignedToday = response.data));
            axios
                .get('/DEV_ONLY/paivittaiset_kaannetty.txt')
                .then(response => (this.resignedToday = response.data));
        }
        /*mounted() {
            const that = this;
            setInterval(function() {
                that.num += 1;
            }, 30000);
        }*/
        /*props: {
            resignedToday: {
                type: Number,
                default: 0
            },
            resignedThisWeek: {
                type: Number,
                default: 0
            },
            resignedThisMonth: {
                type: Number,
                default: 0
            }
        }*/
    }
</script>
