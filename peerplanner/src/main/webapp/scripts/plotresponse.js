const acceptBtn = Array.from(document.querySelectorAll('[data-button]'));
const eventName = document.querySelectorAll('[data-name]');
const eventMsg = document.querySelectorAll('[data-message]');
const eventDate = document.querySelectorAll('[data-date]');
const eventTime = document.querySelectorAll('[data-time]');

acceptBtn.forEach((e) => {
	e.addEventListener('click', () => {
		console.log(calendarEvents);
	})
});




