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

    const side_bar_tabs = document.querySelectorAll('#filter-side-bar li')
    side_bar_tabs.forEach(function(side_bar_tab){
        side_bar_tab.addEventListener('click', function(){
            const target = this.getAttribute('filter-target');
            document.querySelectorAll('.filter').forEach(function(filter){
                if (filter.getAttribute('filter-target') === target) {
                    filter.classList.add('active');
                } else if (filter.classList.contains('active')) {
                    filter.classList.remove('active');
                }
            });
            side_bar_tabs.forEach(function(tab){
                // console.log(tab)
                if (tab === side_bar_tab) {
                    tab.classList.add('active');
                } else if (tab.classList.contains('active')){
                    tab.classList.remove('active');
                }
            })
        });
    });
});