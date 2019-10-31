<template>
    <div id="app" class="container mx-auto py-4 md:py-10 font-body">
        <div class="sm:flex flex-wrap px-6 md:pb-10 w-full h-full">
            <div class="text-center sm:flex-grow">
                <div class="md:mb-10">
                    <p class="text-3xl">Kirkosta on eronnut</p>
                </div>
                <div class="flex flex-wrap leading-tight">
                    <div class="w-full py-3 md:w-1/2 lg:w-1/4">
                        <p class="text-xl">tänään</p>
                        <p class="text-6xl">
                            <IOdometer
                                class="m-0"
                                :value="resignedToday"
                                format="( ddd).dd"
                            ></IOdometer>
                        </p>
                        <p class="text-xl">ihmistä.</p>
                    </div>
                    <div class="w-full py-3 md:w-1/2 lg:w-1/4">
                        <p class="text-xl">
                            tällä viikolla
                        </p>
                        <p class="text-6xl">
                            <IOdometer
                                class="m-0"
                                :value="resignedThisWeek"
                                format="( ddd).dd"
                            ></IOdometer>
                        </p>
                        <p class="text-xl">ihmistä.</p>
                    </div>
                    <div class="w-full py-3 md:w-1/2 lg:w-1/4">
                        <p class="text-xl">tässä kuussa</p>
                        <p class="text-6xl">
                            <IOdometer
                                class="m-0"
                                :value="resignedThisMonth"
                                format="( ddd).dd"
                            ></IOdometer>
                        </p>
                        <p class="text-xl">ihmistä.</p>
                    </div>
                    <div class="w-full py-3 md:w-1/2 lg:w-1/4">
                        <p class="text-xl">tänä vuonna</p>
                        <p class="text-6xl">
                            <IOdometer
                                class="m-0"
                                :value="resignedThisYear"
                                format="( ddd).dd"
                            ></IOdometer>
                        </p>
                        <p class="text-xl">ihmistä.</p>
                    </div>
                </div>
            </div>
        </div>
        <footer class="w-full text-center border-t border-grey p-4 font-">
            <p class="leading-tight text-gray-500">
                Tiedot:
                <a href="http://eroakirkosta.fi">eroakirkosta.fi</a>
            </p>
        </footer>
    </div>
</template>

<style>
html,
body {
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
            resignedThisMonth: 0,
            resignedThisYear: 0
        };
    },
    mounted() {
        let yearStartDate = moment().startOf('year');
        let yearEndDate = moment().endOf('year');
        let monthStartDate = moment().startOf('month');
        let monthEndDate = moment().endOf('month');
        let weekStartDate = moment().startOf('isoWeek');
        let weekEndDate = moment().endOf('isoWeek');
        let currentDate = moment();

        // Resignations this month
        axios
            .get(
                'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                    currentDate.format('DD.MM.YYYY') +
                    '&end=' +
                    currentDate.format('DD.MM.YYYY') +
                    '&accumulate=false'
            )
            .then(response => (this.resignedToday = response.data.totalCount));
        this.interval = setInterval(() => {
            axios
                .get(
                    'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                        currentDate.format('DD.MM.YYYY') +
                        '&end=' +
                        currentDate.format('DD.MM.YYYY') +
                        '&accumulate=false'
                )
                .then(
                    response => (this.resignedToday = response.data.totalCount)
                );
        }, 7000);

        // Resignations this week
        axios
            .get(
                'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                    weekStartDate.format('DD.MM.YYYY') +
                    '&end=' +
                    weekEndDate.format('DD.MM.YYYY') +
                    '&accumulate=false'
            )
            .then(
                response => (this.resignedThisWeek = response.data.totalCount)
            );
        this.interval = setInterval(() => {
            axios
                .get(
                    'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                        weekStartDate.format('DD.MM.YYYY') +
                        '&end=' +
                        weekEndDate.format('DD.MM.YYYY') +
                        '&accumulate=false'
                )
                .then(
                    response =>
                        (this.resignedThisWeek = response.data.totalCount)
                );
        }, 7000);

        // Resignations this month
        axios
            .get(
                'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                    monthStartDate.format('DD.MM.YYYY') +
                    '&end=' +
                    monthEndDate.format('DD.MM.YYYY') +
                    '&accumulate=false'
            )
            .then(
                response => (this.resignedThisMonth = response.data.totalCount)
            );
        this.interval = setInterval(() => {
            axios
                .get(
                    'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                        monthStartDate.format('DD.MM.YYYY') +
                        '&end=' +
                        monthEndDate.format('DD.MM.YYYY') +
                        '&accumulate=false'
                )
                .then(
                    response =>
                        (this.resignedThisMonth = response.data.totalCount)
                );
        }, 7000);

        // Resignations this year
        axios
            .get(
                'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                    yearStartDate.format('DD.MM.YYYY') +
                    '&end=' +
                    yearEndDate.format('DD.MM.YYYY') +
                    '&accumulate=false'
            )
            .then(
                response => (this.resignedThisYear = response.data.totalCount)
            );
        this.interval = setInterval(() => {
            axios
                .get(
                    'http://www.eroakirkosta.fi/dynamic/tilastot.php?start=' +
                        yearStartDate.format('DD.MM.YYYY') +
                        '&end=' +
                        yearEndDate.format('DD.MM.YYYY') +
                        '&accumulate=false'
                )
                .then(
                    response =>
                        (this.resignedThisYear = response.data.totalCount)
                );
        }, 7000);
    }
};
</script>
