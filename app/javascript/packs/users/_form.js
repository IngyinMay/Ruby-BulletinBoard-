$(document).ready(function() {
    $('.super-user-flag').change(function() {
        if (this.value == 'true') {
            $('.user-role').attr('hidden', true);
        } else if (this.value == 'false') {
            $('.user-role').removeAttr('hidden');
        }
    });
    console.log('hello');
});