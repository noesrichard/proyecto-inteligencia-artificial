function app_draw_predictions(prediction, box, component)
    color = set_color(prediction);
    text(component, 'Position',[box(:,1) box(:,2)+10],'String',prediction, 'Color',color);
    rectangle(component, 'position', box(:,:), 'EdgeColor','r');
end
