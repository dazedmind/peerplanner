const body = document.getElementsByName('body');
const profile = document.getElementById('profile-menu')
const hiddenMenu = document.getElementById('hidden-menu')

profile.addEventListener('click', () => {
    hiddenMenu.style.display = "block";
});

profile.addEventListener('mouseleave', () => {
    hiddenMenu.style.display = "none";
});

// call evo calendar
$(document).ready(function() {
    $('#calendar').evoCalendar({
        settingName: settingValue
    })
})

