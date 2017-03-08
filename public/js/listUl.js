var ListUl = function(){
    var listUl = document.getElementById('list-ul');

    var fillContent = function(content){
        var element = document.createElement('li');
        element.innerHTML = content;
        listUl.append(element);
    };

    Bus.subscribe('send content', fillContent);
};
