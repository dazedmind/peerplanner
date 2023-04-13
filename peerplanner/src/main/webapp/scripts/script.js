const body = document.getElementsByName('body');
const profile = document.getElementById('profile-menu')
const hiddenMenu = document.getElementById('hidden-menu')

profile.addEventListener('click', (e) => {
    hiddenMenu.style.display = "block";

});

profile.addEventListener('mouseleave', () => {
    hiddenMenu.style.display = "none";
});

$(document).ready(function() {
    $('#calendar').evoCalendar({
        settingName: settingValue
    })
})