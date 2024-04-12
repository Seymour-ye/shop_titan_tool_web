document.addEventListener('turbo:load', function(){

    console.log("Event Listener initialized");

    document.querySelectorAll('.select-all-button').forEach(function(button){
        button.addEventListener('click', function(){
            const target = this.getAttribute('data-target');
            document.querySelectorAll(`[name^="${target}"]`).forEach(function(checkbox) {
                checkbox.checked = true;
            });
        });
    });

    document.querySelectorAll('.select-none-button').forEach(function(button){
        button.addEventListener('click', function(){
            const target = this.getAttribute('data-target');
            document.querySelectorAll(`[name^="${target}"]`).forEach(function(checkbox) {
                checkbox.checked = false;
            });
        })
    });
});