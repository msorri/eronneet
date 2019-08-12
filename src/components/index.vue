<template>
    <div id="app" class="container mx-auto py-10">
        <div class="sm:flex sm:items-center px-6 py-4 w-full h-full">
            <div class="text-center font-serif sm:flex-grow">
                <div class="mb-10">
                    <p class="text-3xl leading-tight">Kirkosta on eronnut</p>
                </div>
                <div class="flex flex-row flex-wrap items-stretch items-end content-start">
                    <div class="flex-1 w-full">
                        <p class="inline text-xl leading-tight">tänään</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">
                            <IOdometer class="m-0" :value="resignedToday" format="( ddd).dd"></IOdometer>
                        </p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                    <div class="flex-1 w-full">
                        <p class="inline text-xl leading-tight">tällä viikolla</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">
                            <IOdometer class="m-0" :value="resignedThisWeek" format="( ddd).dd"></IOdometer>
                        </p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                    <div class="flex-1 w-full">
                        <p class="inline text-xl leading-tight">tässä kuussa</p>
                        <p class="inline ml-4 mr-4 text-6xl leading-tight font-sans">
                            <IOdometer class="m-0" :value="resignedThisMonth" format="( ddd).dd"></IOdometer>
                        </p>
                        <p class="inline text-xl leading-tight">ihmistä.</p>
                    </div>
                </div>
            </div>
        </div>
        <footer class="w-full text-center border-t border-grey p-4 font-serif">
            <p class="leading-tight text-gray-500">Tiedot: <a href="http://eroakirkosta.fi">eroakirkosta.fi</a></p>
        </footer>
    </div>
</template>

<style>
    html, body {
        height: 100%;
    }
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
                resignedToday: 0,
                resignedThisWeek: 0,
                resignedThisMonth: 0
            }
        },
        mounted() {
            let monthStartDate = moment().startOf('month');
            let monthEndDate = moment().endOf('month');
            let weekStartDate = moment().startOf('isoWeek');
            let weekEndDate = moment().endOf('isoWeek');
            let currentDate = moment();

            // Resignations this month
            axios
                .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + currentDate.format('DD.MM.YYYY') + '&end=' + currentDate.format('DD.MM.YYYY') + '&accumulate=false')
                //.get('http://localhost:8080/DEV_ONLY/rs-' + currentDate.format('DD.MM.YYYY') + '-' + currentDate.format('DD.MM.YYYY') + '.txt')
                .then(response => (this.resignedToday = response.data.totalCount));
            this.interval = setInterval(() => {
                axios
                    .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + currentDate.format('DD.MM.YYYY') + '&end=' + currentDate.format('DD.MM.YYYY') + '&accumulate=false')
                    .then(response => (this.resignedToday = response.data.totalCount));
            }, 5000);

            // Resignations this week
            axios
                .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + weekStartDate.format('DD.MM.YYYY') + '&end=' + weekEndDate.format('DD.MM.YYYY') + '&accumulate=false')
                .then(response => (this.resignedThisWeek = response.data.totalCount));
            this.interval = setInterval(() => {
                axios
                    .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + weekStartDate.format('DD.MM.YYYY') + '&end=' + weekEndDate.format('DD.MM.YYYY') + '&accumulate=false')
                    .then(response => (this.resignedThisWeek = response.data.totalCount));
            }, 5000);

            // Resignations this month
            axios
                .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + monthStartDate.format('DD.MM.YYYY') + '&end=' + monthEndDate.format('DD.MM.YYYY') + '&accumulate=false')
                .then(response => (this.resignedThisMonth = response.data.totalCount));
            this.interval = setInterval(() => {
                axios
                    .get('https://cors-anywhere.herokuapp.com/http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' + monthStartDate.format('DD.MM.YYYY') + '&end=' + monthEndDate.format('DD.MM.YYYY') + '&accumulate=false')
                    .then(response => (this.resignedThisMonth = response.data.totalCount));
            }, 5000);
        }
    }
</script>
