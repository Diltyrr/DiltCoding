import { useBackend } from 'tgui/backend';
import { Box, Section, ProgressBar, Button, Stack, NoticeBox } from 'tgui-core/components';

interface GeoOutletData {
  condenser_temp: number;
  outlet_pressure: number;
  efficiency: number;
  valve: number;
  max_condenser_temp: number;
  max_outlet_pressure: number;
  max_efficiency: number;
  max_valve: number;
}

export const GeoTurbineOutlet = () => {
  const { act, data } = useBackend<GeoOutletData>();

  const { condenser_temp, outlet_pressure, efficiency, valve,
          max_condenser_temp, max_outlet_pressure, max_efficiency, max_valve } = data;

  const adjustSteps = [-10, -5, -1, +1, +5, +10];

  const barColor = (pct: number) => {
    if (pct < 50) return 'good';
    if (pct < 80) return 'average';
    return 'bad';
  };

  return (
    <Box>
      <Section title="Outlet / Condenser Control">
        <Stack vertical>
          <Stack.Item>
            <b>Condenser Temp:</b> {condenser_temp} K
            <ProgressBar
              value={(condenser_temp / max_condenser_temp) * 100}
              color={barColor((condenser_temp / max_condenser_temp) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Outlet Pressure:</b> {outlet_pressure} kPa
            <ProgressBar
              value={(outlet_pressure / max_outlet_pressure) * 100}
              color={barColor((outlet_pressure / max_outlet_pressure) * 100)}
            />
          </Stack.Item>

          <Stack.Item>
            <b>Efficiency:</b> {efficiency} %
            <ProgressBar
              value={(efficiency / max_efficiency) * 100}
              color={barColor((efficiency / max_efficiency) * 100)}
            />
            {efficiency < 30 && (
              <NoticeBox color="bad">
                Warning: Efficiency critically low!
              </NoticeBox>
            )}
          </Stack.Item>

          <Stack.Item>
            <b>Valve Setting:</b> {valve}
            <ProgressBar
              value={(valve / max_valve) * 100}
              color={barColor((valve / max_valve) * 100)}
            />
            <Box textAlign="center">
              {adjustSteps.map((n) => (
                <Button key={n} onClick={() => act('adjust_valve', { amount: n })}>
                  {n > 0 ? `+${n}` : n}
                </Button>
              ))}
            </Box>
          </Stack.Item>
        </Stack>
      </Section>
    </Box>
  );
};
